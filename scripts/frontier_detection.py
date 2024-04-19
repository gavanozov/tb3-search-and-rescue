#!/usr/bin/env python
# Example Python code using rospy
import rospy
import numpy as np
import math
import queue as q
from nav_msgs.msg import OccupancyGrid, Odometry, GridCells
from geometry_msgs.msg import Point

# Classify different cell types in occupancy grid for the map
class CellType:
    UNKNOWN = -1
    FREE = 0
    OCCUPIED = 100

class FrontierDetection:

    def __init__(self):
        rospy.init_node('occupancy_grid_listener')
        # Initialize the robot's location
        self.robot_x = 0
        self.robot_y = 0
        self.timer = 0
        self.initial_position = None
        # Initialize required ROS publishers and subscribers
        self.frontiers_publisher = rospy.Publisher('/frontiers', GridCells, queue_size=10)
        self.closest_frontier_publisher = rospy.Publisher('/closest_frontier', Point, queue_size=10)
        self.pose_subscriber = rospy.Subscriber('/odom', Odometry, self.get_pose)
        self.map_subscriber = rospy.Subscriber('/map', OccupancyGrid, self.occupancy_grid_callback)
        

    def get_pose(self, msg):
        # Get robot position on the map as well as current orientation by subscribing to the odometry topic (/odom)
        self.robot_x = msg.pose.pose.position.x
        self.robot_y = msg.pose.pose.position.y
        self.robot_orientation = msg.pose.pose.orientation

        if self.initial_position == None:
            self.initial_position = (self.robot_x, self.robot_y)

    def get_neighbours(self, cell):
        # Get the neighbours of a cell in the occupancy grid
        neighbors_offsets = [
            (-1, -1), (-1, 0), (-1, 1),
            (0, -1),            (0, 1),
            (1, -1), (1, 0), (1, 1)
        ]

        return [(cell[0] + offset[0], cell[1] + offset[1]) for offset in neighbors_offsets]

    def open_space_check(self, cell, grid):
        # Check whether cells around the input cell are occupied or not
        adjacent_points = self.get_neighbours(cell)

        for adj in adjacent_points:
            if grid[adj[1]][adj[0]] == CellType.FREE:
                return True

    def frontier_check(self, cell, map, grid):
        # Check if input cell is a frontier (it's an unknown cell next to an unoccupied one)
        rows, cols = map.info.height, map.info.width

        neighbors_offsets = self.get_neighbours(cell)

        if grid[cell[1]][cell[0]] == CellType.UNKNOWN:
            for neighbor_x, neighbor_y in neighbors_offsets:

                if 0 <= neighbor_x < rows and 0 <= neighbor_y < cols:
                    if grid[neighbor_y][neighbor_x] == CellType.FREE:
                        return True
                    
    def visualize_frontiers(self, frontier_points, map):
        # Publish detected frontiers to Rviz in order to visualize them
        grid_cells_msg = GridCells()
        grid_cells_msg.header.frame_id = map.header.frame_id
        grid_cells_msg.cell_width = map.info.resolution
        grid_cells_msg.cell_height = map.info.resolution

        # Each cell needs to be visualized separately
        for frontier in frontier_points:
            for point in frontier:
                grid_cells_msg.cells.append(Point(x= (point[0] + 0.5) * map.info.resolution + map.info.origin.position.x, y= (point[1] + 0.5) * map.info.resolution + map.info.origin.position.y, z=0.0))

        self.frontiers_publisher.publish(grid_cells_msg)

    def visualize_cell(self, cell, map):
        # Function for debugging and visualizing separated cells (Not used in main program)
        grid_cells_msg = GridCells()
        grid_cells_msg.header.frame_id = map.header.frame_id
        grid_cells_msg.cell_width = map.info.resolution
        grid_cells_msg.cell_height = map.info.resolution

        for point in cell:
            grid_cells_msg.cells.append(Point(x= (point[0] + 0.5) * map.info.resolution + map.info.origin.position.x, y= (point[1] + 0.5) * map.info.resolution + map.info.origin.position.y, z=0.0))

        self.frontiers_publisher.publish(grid_cells_msg)

    def calculate_median(self, frontier):
        # Calculate the median (middle point) of the input frontier
        middle = int(len(frontier) / 2)
        if len(frontier) == 1:
            return frontier[0]
        else:
            return frontier[middle]
        
    def pick_closest_frontier(self, robot_x, robot_y, medians):
        # Select the closest frontier to the robot when sending navigation messages
        closest_frontier = medians[0]
        for median in medians:
            if math.sqrt((median[1] - robot_x)**2 + (median[0] - robot_y)**2) < math.sqrt((closest_frontier[1] - robot_x)**2 + (closest_frontier[0] - robot_y)**2):
                closest_frontier = median
        return closest_frontier

    def publish_closest_frontier(self, frontier, map):
        # Publish the closest to the robot frontier median in order for it to be processed by the navigation stack
        frontier_median_msg = Point() # Create a Point object for the message to be published
        frontier_median_msg.x = (frontier[0] + 0.5) * map.info.resolution + map.info.origin.position.x
        frontier_median_msg.y = (frontier[1] + 0.5) * map.info.resolution + map.info.origin.position.y
        frontier_median_msg.z = 0.0

        self.closest_frontier_publisher.publish(frontier_median_msg)

    def publish_end_goal(self, point):
        # Publish the end goal location which is the robot's starting location
        end_goal_msg = Point()
        end_goal_msg.x = point[0]
        end_goal_msg.y = point[1]
        end_goal_msg.z = 0.0

        self.closest_frontier_publisher.publish(end_goal_msg)
            

    
    def occupancy_grid_callback(self, msg):
        # Frontier detection algorithm starts here
        # Create four sets, two for each of the BFSs (Breadth-First Search)
        mol = set()
        mcl = set()
        fol = set()
        fcl = set()

        # Keep track of current frontiers and their medians
        frontiers = []
        frontier_medians = []

        # Process map information to be used in the function
        height = msg.info.height
        width = msg.info.width
        resolution = msg.info.resolution

        # Reshape 1D array to 2D grid
        occupancy_grid = np.array(msg.data).reshape((height, width))

        # Convert the robot's coordinates on the map into a coordinate on the occupancy grid
        robot_grid = (
            round(abs((self.robot_x - msg.info.origin.position.x) / resolution)),
            round(abs((self.robot_y - msg.info.origin.position.y) / resolution))
        )

        # Here starts the frontier detection algorithm
        queue_m = q.Queue()
        queue_m.put(robot_grid)
        mol.add(robot_grid)

        while not queue_m.empty():
            current_cell = queue_m.get()
            if current_cell in mcl:
                continue
            if self.frontier_check(current_cell, msg, occupancy_grid):
                queue_f = q.Queue()
                new_frontier = []
                queue_f.put(current_cell)
                fol.add(current_cell)
                while not queue_f.empty():
                    current_frontier = queue_f.get()
                    if current_frontier in mcl and current_frontier in fcl:
                        continue
                    if self.frontier_check(current_frontier, msg, occupancy_grid):
                        new_frontier.append(current_frontier)
                        for adj_f in self.get_neighbours(current_frontier):
                            if adj_f not in fol and adj_f not in fcl and adj_f not in mcl:
                                queue_f.put(adj_f)
                                fol.add(adj_f)
                    fcl.add(current_frontier)
                if len(new_frontier) > 22: 
                    frontiers.append(new_frontier)
                    new_median = self.calculate_median(new_frontier) 
                    if new_median not in frontier_medians:
                        frontier_medians.append(new_median)
                for f in new_frontier:
                    mcl.add(f)
            for adj_c in self.get_neighbours(current_cell):
                if (adj_c not in mol and adj_c not in mcl) and (self.open_space_check(adj_c, occupancy_grid)):
                    queue_m.put(adj_c)
                    mol.add(adj_c)
            mcl.add(current_cell)
        self.visualize_frontiers(frontiers, msg)
        if frontier_medians:
            self.publish_closest_frontier(self.pick_closest_frontier(robot_grid[1], robot_grid[0], frontier_medians), msg)
            print(f"Closest frontier is at coordinates {self.pick_closest_frontier(robot_grid[1], robot_grid[0], frontier_medians)}")
            self.timer = 0
        else:
            self.timer += 1
        if self.initial_position != None and self.timer >= 2:
            self.publish_end_goal((self.initial_position[0], self.initial_position[1]))
            self.timer = 0
            print("Returning to starting location!")

if __name__ == "__main__":
    FrontierDetection()
    while not rospy.is_shutdown():
        rospy.spin()