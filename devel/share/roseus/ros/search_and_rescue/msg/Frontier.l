;; Auto-generated. Do not edit!


(when (boundp 'search_and_rescue::Frontier)
  (if (not (find-package "SEARCH_AND_RESCUE"))
    (make-package "SEARCH_AND_RESCUE"))
  (shadow 'Frontier (find-package "SEARCH_AND_RESCUE")))
(unless (find-package "SEARCH_AND_RESCUE::FRONTIER")
  (make-package "SEARCH_AND_RESCUE::FRONTIER"))

(in-package "ROS")
;;//! \htmlinclude Frontier.msg.html


(defclass search_and_rescue::Frontier
  :super ros::object
  :slots (_cells ))

(defmethod search_and_rescue::Frontier
  (:init
   (&key
    ((:cells __cells) ())
    )
   (send-super :init)
   (setq _cells __cells)
   self)
  (:cells
   (&rest __cells)
   (if (keywordp (car __cells))
       (send* _cells __cells)
     (progn
       (if __cells (setq _cells (car __cells)))
       _cells)))
  (:serialization-length
   ()
   (+
    ;; search_and_rescue/Cell[] _cells
    (apply #'+ (send-all _cells :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; search_and_rescue/Cell[] _cells
     (write-long (length _cells) s)
     (dolist (elem _cells)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; search_and_rescue/Cell[] _cells
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _cells (let (r) (dotimes (i n) (push (instance search_and_rescue::Cell :init) r)) r))
     (dolist (elem- _cells)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get search_and_rescue::Frontier :md5sum-) "1b8456de71852d4b418f0efe52e743ad")
(setf (get search_and_rescue::Frontier :datatype-) "search_and_rescue/Frontier")
(setf (get search_and_rescue::Frontier :definition-)
      "# Frontier.msg

Cell[] cells # List of cells
================================================================================
MSG: search_and_rescue/Cell
# Cell.msg

int32 x
int32 y
")



(provide :search_and_rescue/Frontier "1b8456de71852d4b418f0efe52e743ad")


