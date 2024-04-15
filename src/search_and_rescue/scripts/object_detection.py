#!/usr/bin/env python

import rospy
import cv2
import numpy as np
import math
import time
from cv_bridge import CvBridge
from sensor_msgs.msg import Image
from nav_msgs.msg import Odometry
from visualization_msgs.msg import Marker
from geometry_msgs.msg import Quaternion
from tf.transformations import euler_from_quaternion

class ObjectDetection:

    def __init__(self):
        rospy.init_node('object_detection')
        self.camera_subscriber = rospy.Subscriber('/camera/rgb/image_raw', Image, self.image_callback)
        self.pose_subscriber = rospy.Subscriber('/odom', Odometry, self.get_pose)
        self.object_publisher = rospy.Publisher('/visualization_marker', Marker, queue_size=0)
        self.bridge = CvBridge()
        self.focal_length = 0.304
        self.pixel_size = 0.000575
        self.camera_fov = math.radians(62.2) # Default TurtleBot3 Camera FOV (Field of View)
        self.object_number = 0
        self.object_locations = []
        self.object_timings = {}  # Dictionary to store timing information
        self.detection_threshold = 0.1  # Time in seconds an object must be visible to be confirmed

    def get_pose(self, msg):
        self.robot_x = msg.pose.pose.position.x
        self.robot_y = msg.pose.pose.position.y
        self.robot_orientation = msg.pose.pose.orientation
        orientation_list = [self.robot_orientation.x, self.robot_orientation.y, self.robot_orientation.z, self.robot_orientation.w]
        (roll, pitch, yaw) = euler_from_quaternion(orientation_list)
        self.robot_yaw = yaw

    def euclidean_distance(self, start, end):
        return math.sqrt((start[0] - end[0])**2 + (start[1] - end[1])**2)
    
    def is_close(self, point):
        for loc in self.object_locations:
            if self.euclidean_distance(loc, point) <= 1:
                return True
        return False

    def object_distance(self, object_width):
        real_object_size = 0.0662
        object_size_in_image = object_width * self.pixel_size

        # Scale-based distance estimation
        distance = (real_object_size * self.focal_length) / object_size_in_image

        return distance
    
    def object_position(self, distance, object_angle):
        angle = self.robot_yaw - object_angle

        object_x = self.robot_x + distance * math.cos(angle)
        object_y = self.robot_y + distance * math.sin(angle)

        return (object_x, object_y)


    def object_marker(self, x, y):
        marker = Marker()
        marker.header.frame_id = "map"  # Assuming the map frame
        marker.header.stamp = rospy.Time.now()
        marker.ns = "object"
        self.object_number += 1
        marker.id = self.object_number
        marker.type = Marker.SPHERE
        marker.pose.position.x = x
        marker.pose.position.y = y
        marker.pose.position.z = 0.0
        marker.pose.orientation.x = 0.0
        marker.pose.orientation.y = 0.0
        marker.pose.orientation.z = 0.0
        marker.pose.orientation.w = 1.0
        marker.scale.x = marker.scale.y = marker.scale.z = 0.3 # Adjust size as needed
        marker.color.r = 1.0  # Red color
        marker.color.g = 0.0
        marker.color.b = 0.0
        marker.color.a = 1.0
        marker.lifetime = rospy.Duration()
        self.object_publisher.publish(marker)

    def image_callback(self, msg):
            
            cv_image = self.bridge.imgmsg_to_cv2(msg, "bgr8")
            hsv = cv2.cvtColor(cv_image, cv2.COLOR_BGR2HSV)

            # Define lower and upper bounds for the first range (0-10)
            lower_red1 = np.array([0, 10, 20])
            upper_red1 = np.array([5, 255, 255])

            # Define lower and upper bounds for the second range (170-180)
            lower_red2 = np.array([170, 10, 20])
            upper_red2 = np.array([180, 255, 255])

            # Create masks for each range
            mask1 = cv2.inRange(hsv, lower_red1, upper_red1)
            mask2 = cv2.inRange(hsv, lower_red2, upper_red2)

            # Combine the masks
            mask = cv2.bitwise_or(mask1, mask2)

            # Find contours of the detected regions
            contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

            # Filter contours based on shape and size
            min_contour_area = 100  # Adjust as needed
            min_aspect_ratio = 0.3   # Adjust as needed
            max_aspect_ratio = 0.7   # Adjust as needed
    
            detected_coke_cans = []
            current_time = time.time()

            for contour in contours:
                area = cv2.contourArea(contour)
                x, y, w, h = cv2.boundingRect(contour)
                aspect_ratio = float(w) / h

                if area > min_contour_area and min_aspect_ratio < aspect_ratio < max_aspect_ratio:
                    detected_coke_cans.append(contour)

            if detected_coke_cans:
                # Assume the largest contour corresponds to the object of interest
                largest_contour = None
                largest_contour = max(detected_coke_cans, key=cv2.contourArea)
                # Draw bounding box around each filtered contour
                x, y, w, h = cv2.boundingRect(largest_contour)
                cv2.rectangle(cv_image, (x, y), (x + w, y + h), (0, 255, 0), 2)

                # Calculate the center of the contour
                cx = x + w / 2

                object_center = (x + w / 2, y + h / 2)

                if object_center not in self.object_timings:
                    # Record the time this object was first detected
                    self.object_timings[object_center] = current_time
                else:
                    # Check if the object has been visible for longer than the threshold
                    time_visible = current_time - self.object_timings[object_center]
                    if time_visible >= self.detection_threshold:
                        rospy.loginfo(f"Object at {object_center} confirmed after {self.detection_threshold} seconds")
                        # Calculate displacement from the center of the image
                        image_center_x = cv_image.shape[1] / 2
                        displacement_from_center = cx - image_center_x

                        # Calculate the angle to the object
                        angle_per_pixel = self.camera_fov / cv_image.shape[1]
                        angle_to_object = displacement_from_center * angle_per_pixel
                        #rospy.loginfo(f"Object detected at pixel {cx}, angle {angle_to_object} rad relative to camera center")
  
                        object_distance = self.object_distance(w)
                        object_position = self.object_position(object_distance, angle_to_object)
                
                        if not self.is_close(object_position):
                            self.object_marker(object_position[0], object_position[1])
                            self.object_locations.append(object_position)
                    else:
                        rospy.loginfo(f"Object at {object_center} detected but not confirmed. Visible for {time_visible:.2f} seconds")


                #(object_x, object_y) = self.object_position(self.object_distance(w), angle_to_object)

                #print(object_x, object_y)


            mask = cv2.cvtColor(mask, cv2.COLOR_GRAY2BGR)
            
            
            numpy_concat = np.concatenate((cv_image, mask), axis=0)


            cv2.imshow("bruh", numpy_concat)

            
            #self.object_position(self.object_distance(w))
            #print(self.object_distance(w))
            #self.object_marker(object_x, object_y)

            cv2.waitKey(1)

if __name__ == "__main__":
    ObjectDetection()
    rospy.spin()