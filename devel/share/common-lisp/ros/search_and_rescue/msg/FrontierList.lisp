; Auto-generated. Do not edit!


(cl:in-package search_and_rescue-msg)


;//! \htmlinclude FrontierList.msg.html

(cl:defclass <FrontierList> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (frontiers
    :reader frontiers
    :initarg :frontiers
    :type (cl:vector search_and_rescue-msg:Frontier)
   :initform (cl:make-array 0 :element-type 'search_and_rescue-msg:Frontier :initial-element (cl:make-instance 'search_and_rescue-msg:Frontier))))
)

(cl:defclass FrontierList (<FrontierList>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <FrontierList>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'FrontierList)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name search_and_rescue-msg:<FrontierList> is deprecated: use search_and_rescue-msg:FrontierList instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <FrontierList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader search_and_rescue-msg:header-val is deprecated.  Use search_and_rescue-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'frontiers-val :lambda-list '(m))
(cl:defmethod frontiers-val ((m <FrontierList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader search_and_rescue-msg:frontiers-val is deprecated.  Use search_and_rescue-msg:frontiers instead.")
  (frontiers m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <FrontierList>) ostream)
  "Serializes a message object of type '<FrontierList>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'frontiers))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'frontiers))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <FrontierList>) istream)
  "Deserializes a message object of type '<FrontierList>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'frontiers) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'frontiers)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'search_and_rescue-msg:Frontier))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<FrontierList>)))
  "Returns string type for a message object of type '<FrontierList>"
  "search_and_rescue/FrontierList")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'FrontierList)))
  "Returns string type for a message object of type 'FrontierList"
  "search_and_rescue/FrontierList")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<FrontierList>)))
  "Returns md5sum for a message object of type '<FrontierList>"
  "d8bff21bf47ea8f3347bdb50aeb48771")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'FrontierList)))
  "Returns md5sum for a message object of type 'FrontierList"
  "d8bff21bf47ea8f3347bdb50aeb48771")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<FrontierList>)))
  "Returns full string definition for message of type '<FrontierList>"
  (cl:format cl:nil "# FrontierList.msg~%~%Header header # Standard ROS Header~%Frontier[] frontiers # List of frontiers ~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: search_and_rescue/Frontier~%# Frontier.msg~%~%Cell[] cells # List of cells~%================================================================================~%MSG: search_and_rescue/Cell~%# Cell.msg~%~%int32 x~%int32 y~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'FrontierList)))
  "Returns full string definition for message of type 'FrontierList"
  (cl:format cl:nil "# FrontierList.msg~%~%Header header # Standard ROS Header~%Frontier[] frontiers # List of frontiers ~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: search_and_rescue/Frontier~%# Frontier.msg~%~%Cell[] cells # List of cells~%================================================================================~%MSG: search_and_rescue/Cell~%# Cell.msg~%~%int32 x~%int32 y~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <FrontierList>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'frontiers) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <FrontierList>))
  "Converts a ROS message object to a list"
  (cl:list 'FrontierList
    (cl:cons ':header (header msg))
    (cl:cons ':frontiers (frontiers msg))
))
