# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "search_and_rescue: 1 messages, 0 services")

set(MSG_I_FLAGS "-Isearch_and_rescue:/home/ivang/catkin_ws/src/search_and_rescue/msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(search_and_rescue_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/ivang/catkin_ws/src/search_and_rescue/msg/PointList.msg" NAME_WE)
add_custom_target(_search_and_rescue_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "search_and_rescue" "/home/ivang/catkin_ws/src/search_and_rescue/msg/PointList.msg" "geometry_msgs/Point"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(search_and_rescue
  "/home/ivang/catkin_ws/src/search_and_rescue/msg/PointList.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/search_and_rescue
)

### Generating Services

### Generating Module File
_generate_module_cpp(search_and_rescue
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/search_and_rescue
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(search_and_rescue_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(search_and_rescue_generate_messages search_and_rescue_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ivang/catkin_ws/src/search_and_rescue/msg/PointList.msg" NAME_WE)
add_dependencies(search_and_rescue_generate_messages_cpp _search_and_rescue_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(search_and_rescue_gencpp)
add_dependencies(search_and_rescue_gencpp search_and_rescue_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS search_and_rescue_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(search_and_rescue
  "/home/ivang/catkin_ws/src/search_and_rescue/msg/PointList.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/search_and_rescue
)

### Generating Services

### Generating Module File
_generate_module_eus(search_and_rescue
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/search_and_rescue
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(search_and_rescue_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(search_and_rescue_generate_messages search_and_rescue_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ivang/catkin_ws/src/search_and_rescue/msg/PointList.msg" NAME_WE)
add_dependencies(search_and_rescue_generate_messages_eus _search_and_rescue_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(search_and_rescue_geneus)
add_dependencies(search_and_rescue_geneus search_and_rescue_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS search_and_rescue_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(search_and_rescue
  "/home/ivang/catkin_ws/src/search_and_rescue/msg/PointList.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/search_and_rescue
)

### Generating Services

### Generating Module File
_generate_module_lisp(search_and_rescue
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/search_and_rescue
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(search_and_rescue_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(search_and_rescue_generate_messages search_and_rescue_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ivang/catkin_ws/src/search_and_rescue/msg/PointList.msg" NAME_WE)
add_dependencies(search_and_rescue_generate_messages_lisp _search_and_rescue_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(search_and_rescue_genlisp)
add_dependencies(search_and_rescue_genlisp search_and_rescue_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS search_and_rescue_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(search_and_rescue
  "/home/ivang/catkin_ws/src/search_and_rescue/msg/PointList.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/search_and_rescue
)

### Generating Services

### Generating Module File
_generate_module_nodejs(search_and_rescue
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/search_and_rescue
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(search_and_rescue_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(search_and_rescue_generate_messages search_and_rescue_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ivang/catkin_ws/src/search_and_rescue/msg/PointList.msg" NAME_WE)
add_dependencies(search_and_rescue_generate_messages_nodejs _search_and_rescue_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(search_and_rescue_gennodejs)
add_dependencies(search_and_rescue_gennodejs search_and_rescue_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS search_and_rescue_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(search_and_rescue
  "/home/ivang/catkin_ws/src/search_and_rescue/msg/PointList.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/search_and_rescue
)

### Generating Services

### Generating Module File
_generate_module_py(search_and_rescue
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/search_and_rescue
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(search_and_rescue_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(search_and_rescue_generate_messages search_and_rescue_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ivang/catkin_ws/src/search_and_rescue/msg/PointList.msg" NAME_WE)
add_dependencies(search_and_rescue_generate_messages_py _search_and_rescue_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(search_and_rescue_genpy)
add_dependencies(search_and_rescue_genpy search_and_rescue_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS search_and_rescue_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/search_and_rescue)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/search_and_rescue
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(search_and_rescue_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(search_and_rescue_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/search_and_rescue)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/search_and_rescue
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(search_and_rescue_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(search_and_rescue_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/search_and_rescue)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/search_and_rescue
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(search_and_rescue_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(search_and_rescue_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/search_and_rescue)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/search_and_rescue
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(search_and_rescue_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(search_and_rescue_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/search_and_rescue)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/search_and_rescue\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/search_and_rescue
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(search_and_rescue_generate_messages_py geometry_msgs_generate_messages_py)
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(search_and_rescue_generate_messages_py std_msgs_generate_messages_py)
endif()
