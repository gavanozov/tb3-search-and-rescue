#!/usr/bin/env python
import rospy
import actionlib
import time
from nav_msgs.msg import Odometry
from geometry_msgs.msg import Point, PoseWithCovarianceStamped
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal
from sound_play.libsoundplay import SoundClient


class FrontierNavigation:

    def __init__(self):
        rospy.init_node('frontier_navigation')
        self.pose_publisher = rospy.Publisher('/initialpose', PoseWithCovarianceStamped, queue_size=0)
        self.pose_subscriber = rospy.Subscriber('/odom', Odometry, self.get_pose)
        self.closest_frontier_subscriber = rospy.Subscriber('/closest_frontier', Point, self.navigation_callback)
        self.move_base_client = actionlib.SimpleActionClient('move_base', MoveBaseAction)
        self.move_base_client.wait_for_server()
        self.sound_client = SoundClient()
        self.timer = None

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

        rospy.loginfo("Robot pose set to: x={}, y={}, orientation={}".format(x, y, orientation))

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
    
    def start_timer(self, data):
        if not data:  # Assuming the message is empty when no frontiers
            if not self.timer:
                self.timer = time.time()
        else:
            self.timer = None  # Reset timer if frontiers are found

    def sound_maker(self):
        if self.timer and (time.time() - self.timer > 10):  # 10 second delay
            self.sound_client.playWave('/../sounds/victory.wav')
            rospy.loginfo("All frontiers explored, sound played.")
            self.timer = None  # Reset timer
    
    def navigation_callback(self, msg):
        
        self.set_robot_pose(self.robot_x, self.robot_y, self.robot_orientation)
        
        print(msg)

        self.send_goal(msg)

        self.start_timer(msg)

        self.sound_maker
        

if __name__ == "__main__":
    FrontierNavigation()
    rospy.spin()