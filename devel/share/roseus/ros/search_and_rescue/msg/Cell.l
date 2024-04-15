;; Auto-generated. Do not edit!


(when (boundp 'search_and_rescue::Cell)
  (if (not (find-package "SEARCH_AND_RESCUE"))
    (make-package "SEARCH_AND_RESCUE"))
  (shadow 'Cell (find-package "SEARCH_AND_RESCUE")))
(unless (find-package "SEARCH_AND_RESCUE::CELL")
  (make-package "SEARCH_AND_RESCUE::CELL"))

(in-package "ROS")
;;//! \htmlinclude Cell.msg.html


(defclass search_and_rescue::Cell
  :super ros::object
  :slots (_x _y ))

(defmethod search_and_rescue::Cell
  (:init
   (&key
    ((:x __x) 0)
    ((:y __y) 0)
    )
   (send-super :init)
   (setq _x (round __x))
   (setq _y (round __y))
   self)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:serialization-length
   ()
   (+
    ;; int32 _x
    4
    ;; int32 _y
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _x
       (write-long _x s)
     ;; int32 _y
       (write-long _y s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _x
     (setq _x (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _y
     (setq _y (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get search_and_rescue::Cell :md5sum-) "bd7b43fd41d4c47bf5c703cc7d016709")
(setf (get search_and_rescue::Cell :datatype-) "search_and_rescue/Cell")
(setf (get search_and_rescue::Cell :definition-)
      "# Cell.msg

int32 x
int32 y
")



(provide :search_and_rescue/Cell "bd7b43fd41d4c47bf5c703cc7d016709")


