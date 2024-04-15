
(cl:in-package :asdf)

(defsystem "search_and_rescue-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
)
  :components ((:file "_package")
    (:file "PointList" :depends-on ("_package_PointList"))
    (:file "_package_PointList" :depends-on ("_package"))
  ))