#!/usr/bin/env python
# Example Python code using rospy
import rospy
import numpy as np
import math
import queue as q
from nav_msgs.msg import OccupancyGrid, Odometry, GridCells
from geometry_msgs.msg import Point, Twist


class CellType:
    UNKNOWN = -1
    FREE = 0
    OCCUPIED = 100

class FrontierDetection:

    def __init__(self):
        rospy.init_node('occupancy_grid_listener')
        self.initial_position = None
        self.frontiers_publisher = rospy.Publisher('/frontiers', GridCells, queue_size=0)
        self.closest_frontier_publisher = rospy.Publisher('/closest_frontier', Point, queue_size=0)
        self.pose_subscriber = rospy.Subscriber('/odom', Odometry, self.get_pose)
        self.map_subscriber = rospy.Subscriber('/map', OccupancyGrid, self.occupancy_grid_callback)
        

    def get_pose(self, msg):
        self.robot_x = msg.pose.pose.position.x
        self.robot_y = msg.pose.pose.position.y
        self.robot_orientation = msg.pose.pose.orientation

        if self.initial_position == None:
            self.initial_position = (self.robot_x, self.robot_y)

    def get_neighbours(self, cell):

        neighbors_offsets = [
            (-1, -1), (-1, 0), (-1, 1),
            (0, -1),            (0, 1),
            (1, -1), (1, 0), (1, 1)
        ]

        return [(cell[0] + offset[0], cell[1] + offset[1]) for offset in neighbors_offsets]

    def open_space_check(self, cell, grid):

        adjacent_points = self.get_neighbours(cell)

        for adj in adjacent_points:
            if grid[adj[1]][adj[0]] == CellType.FREE:
                return True

    def frontier_check(self, cell, map, grid):

        rows, cols = map.info.height, map.info.width

        neighbors_offsets = self.get_neighbours(cell)

        if grid[cell[1]][cell[0]] == CellType.UNKNOWN:
            for neighbor_x, neighbor_y in neighbors_offsets:

                if 0 <= neighbor_x < rows and 0 <= neighbor_y < cols:
                    if grid[neighbor_y][neighbor_x] == CellType.FREE: # or grid[neighbor_y][neighbor_x] == CellType.OCCUPIED:
                        return True
    
    def frontier_omit(self, frontier, grid):

        limit = 0

        for cell in frontier:
            adjacent_points = self.get_neighbours(cell)
            for adj in adjacent_points:
                if grid[adj[1]][adj[0]] == CellType.OCCUPIED:
                    limit += 1
        return limit < 25


                    
    def visualize_frontiers(self, frontier_points, map):
        grid_cells_msg = GridCells()
        grid_cells_msg.header.frame_id = map.header.frame_id
        grid_cells_msg.cell_width = map.info.resolution
        grid_cells_msg.cell_height = map.info.resolution

        for frontier in frontier_points:
            for point in frontier:
                grid_cells_msg.cells.append(Point(x= (point[0] + 0.5) * map.info.resolution + map.info.origin.position.x, y= (point[1] + 0.5) * map.info.resolution + map.info.origin.position.y, z=0.0))

        self.frontiers_publisher.publish(grid_cells_msg)
        #rospy.loginfo("Frontiers published: {}".format(grid_cells_msg.cells))

    def visualize_cell(self, cell, map):
        grid_cells_msg = GridCells()
        grid_cells_msg.header.frame_id = map.header.frame_id
        grid_cells_msg.cell_width = map.info.resolution
        grid_cells_msg.cell_height = map.info.resolution

        for point in cell:
            grid_cells_msg.cells.append(Point(x= (point[0] + 0.5) * map.info.resolution + map.info.origin.position.x, y= (point[1] + 0.5) * map.info.resolution + map.info.origin.position.y, z=0.0))

        self.frontiers_publisher.publish(grid_cells_msg)

    def save_frontier(self, new_frontier, frontiers):
        #if new_frontier not in frontiers:
        frontiers.append(new_frontier)

    def calculate_median(self, frontier):
        middle = int(len(frontier) / 2)
        if len(frontier) == 1:
            return frontier[0]
        else:
            return frontier[middle]
        
    def pick_closest_frontier(self, robot_x, robot_y, medians):
        closest_frontier = medians[0]
        for median in medians:
            if math.sqrt((median[1] - robot_x)**2 + (median[0] - robot_y)**2) < math.sqrt((closest_frontier[1] - robot_x)**2 + (closest_frontier[0] - robot_y)**2):
                closest_frontier = median
        return closest_frontier

    def publish_closest_frontier(self, frontier, map):
        
        frontier_median_msg = Point()

        frontier_median_msg.x = (frontier[0] + 0.5) * map.info.resolution + map.info.origin.position.x
        frontier_median_msg.y = (frontier[1] + 0.5) * map.info.resolution + map.info.origin.position.y
        frontier_median_msg.z = 0.0

        self.closest_frontier_publisher.publish(frontier_median_msg)

    def publish_end_goal(self, point):

        end_goal_msg = Point()

        end_goal_msg.x = point[0]
        end_goal_msg.y = point[1]
        end_goal_msg.z = 0.0

        self.closest_frontier_publisher.publish(end_goal_msg)
            

    
    def occupancy_grid_callback(self, msg):

        print(self.initial_position)
        # Access the occupancy grid data here
        mol = set()
        mcl = set()
        fol = set()
        fcl = set()

        frontiers = list()
        frontier_medians = list()

        # Your processing code here
        height = msg.info.height
        width = msg.info.width
        resolution = msg.info.resolution

        # Reshape 1D array to 2D grid
        occupancy_grid = np.array(msg.data).reshape((height, width))

        robot_grid = (
            round(abs((self.robot_x - msg.info.origin.position.x) / resolution)),
            round(abs((self.robot_y - msg.info.origin.position.y) / resolution))
        )

        queue_m = q.Queue()
        queue_m.put(robot_grid)
        mol.add(robot_grid)

        #cells = []

        #print(self.robot_orientation)

        while not queue_m.empty():
            #self.refresh_frontiers(self.frontiers, msg, occupancy_grid)
            current_cell = queue_m.get()
            #cells.append(current_cell)
            #self.visualize_cell(cells, msg)
            if current_cell in mcl:
                continue
            if self.frontier_check(current_cell, msg, occupancy_grid):
                queue_f = q.Queue()
                new_frontier = list()
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
                if len(new_frontier) > 24: 
                    self.save_frontier(new_frontier, frontiers)
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
            #self.visualize_cell(frontier_medians, msg)
            self.publish_closest_frontier(self.pick_closest_frontier(robot_grid[1], robot_grid[0], frontier_medians), msg)
            print(self.pick_closest_frontier(robot_grid[1], robot_grid[0], frontier_medians))
        else:
            self.publish_end_goal((self.initial_position[0], self.initial_position[1]))
            #self.publish_end_goal((-3, 1), msg)
        #print(self.robot_x, self.robot_y, self.robot_orientation)
        #closest_frontier = self.pick_closest_frontier(robot_grid[0], robot_grid[1], frontier_medians)


if __name__ == "__main__":
    FrontierDetection()
    while not rospy.is_shutdown():
        rospy.spin()