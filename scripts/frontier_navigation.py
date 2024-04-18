#!/usr/bin/env python
import rospy
import actionlib
import threading
from nav_msgs.msg import Odometry
from geometry_msgs.msg import Point, PoseWithCovarianceStamped
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal


class FrontierNavigation:

    def __init__(self):
        rospy.init_node('frontier_navigation')
        self.pose_publisher = rospy.Publisher('/initialpose', PoseWithCovarianceStamped, queue_size=10)
        self.pose_subscriber = rospy.Subscriber('/odom', Odometry, self.get_pose)
        self.closest_frontier_subscriber = rospy.Subscriber('/closest_frontier', Point, self.navigation_callback)
        self.move_base_client = actionlib.SimpleActionClient('move_base', MoveBaseAction)
        self.move_base_client.wait_for_server()

    def get_pose(self, msg):
        self.robot_x = msg.pose.pose.position.x
        self.robot_y = msg.pose.pose.position.y
        self.robot_orientation = msg.pose.pose.orientation

    def set_robot_pose(self, x, y, orientation):
        # Create a PoseWithCovarianceStamped message
        pose_msg = PoseWithCovarianceStamped()

        # Set the pose values
        pose_msg.pose.pose.position.x = x
        pose_msg.pose.pose.position.y = y
        pose_msg.pose.pose.position.z = 0.0

        pose_msg.pose.pose.orientation = orientation

        # Publish the message
        self.pose_publisher.publish(pose_msg)

        #rospy.loginfo("Robot pose set to: x={}, y={}, orientation={}".format(x, y, orientation))

    def send_goal(self, cell):

        goal = MoveBaseGoal()
        goal.target_pose.header.frame_id = 'map'
        goal.target_pose.header.stamp = rospy.Time.now()

        # Set the goal position
        goal.target_pose.pose.position.x = cell.x
        goal.target_pose.pose.position.y = cell.y
        goal.target_pose.pose.position.z = 0.0

        # Set the orientation (facing forward)
        goal.target_pose.pose.orientation = self.robot_orientation
        
        # Send the goal
        rospy.loginfo(f'Sending goal to ({cell.x}, {cell.y})')
        self.move_base_client.send_goal(goal)

        # Wait for the result
        #self.move_base_client.wait_for_result()
        return self.move_base_client.get_state() == actionlib.GoalStatus.SUCCEEDED
    
    def navigation_callback(self, msg):
        
        self.set_robot_pose(self.robot_x, self.robot_y, self.robot_orientation)

        self.send_goal(msg)

if __name__ == "__main__":
    FrontierNavigation()
    rospy.spin()