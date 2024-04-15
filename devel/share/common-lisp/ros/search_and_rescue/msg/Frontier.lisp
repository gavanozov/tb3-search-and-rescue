; Auto-generated. Do not edit!


(cl:in-package search_and_rescue-msg)


;//! \htmlinclude Frontier.msg.html

(cl:defclass <Frontier> (roslisp-msg-protocol:ros-message)
  ((cells
    :reader cells
    :initarg :cells
    :type (cl:vector search_and_rescue-msg:Cell)
   :initform (cl:make-array 0 :element-type 'search_and_rescue-msg:Cell :initial-element (cl:make-instance 'search_and_rescue-msg:Cell))))
)

(cl:defclass Frontier (<Frontier>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Frontier>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Frontier)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name search_and_rescue-msg:<Frontier> is deprecated: use search_and_rescue-msg:Frontier instead.")))

(cl:ensure-generic-function 'cells-val :lambda-list '(m))
(cl:defmethod cells-val ((m <Frontier>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader search_and_rescue-msg:cells-val is deprecated.  Use search_and_rescue-msg:cells instead.")
  (cells m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Frontier>) ostream)
  "Serializes a message object of type '<Frontier>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'cells))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'cells))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Frontier>) istream)
  "Deserializes a message object of type '<Frontier>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'cells) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'cells)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'search_and_rescue-msg:Cell))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Frontier>)))
  "Returns string type for a message object of type '<Frontier>"
  "search_and_rescue/Frontier")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Frontier)))
  "Returns string type for a message object of type 'Frontier"
  "search_and_rescue/Frontier")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Frontier>)))
  "Returns md5sum for a message object of type '<Frontier>"
  "1b8456de71852d4b418f0efe52e743ad")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Frontier)))
  "Returns md5sum for a message object of type 'Frontier"
  "1b8456de71852d4b418f0efe52e743ad")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Frontier>)))
  "Returns full string definition for message of type '<Frontier>"
  (cl:format cl:nil "# Frontier.msg~%~%Cell[] cells # List of cells~%================================================================================~%MSG: search_and_rescue/Cell~%# Cell.msg~%~%int32 x~%int32 y~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Frontier)))
  "Returns full string definition for message of type 'Frontier"
  (cl:format cl:nil "# Frontier.msg~%~%Cell[] cells # List of cells~%================================================================================~%MSG: search_and_rescue/Cell~%# Cell.msg~%~%int32 x~%int32 y~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Frontier>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'cells) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Frontier>))
  "Converts a ROS message object to a list"
  (cl:list 'Frontier
    (cl:cons ':cells (cells msg))
))
