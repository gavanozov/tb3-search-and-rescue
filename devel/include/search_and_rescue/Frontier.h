// Generated by gencpp from file search_and_rescue/Frontier.msg
// DO NOT EDIT!


#ifndef SEARCH_AND_RESCUE_MESSAGE_FRONTIER_H
#define SEARCH_AND_RESCUE_MESSAGE_FRONTIER_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <search_and_rescue/Cell.h>

namespace search_and_rescue
{
template <class ContainerAllocator>
struct Frontier_
{
  typedef Frontier_<ContainerAllocator> Type;

  Frontier_()
    : cells()  {
    }
  Frontier_(const ContainerAllocator& _alloc)
    : cells(_alloc)  {
  (void)_alloc;
    }



   typedef std::vector< ::search_and_rescue::Cell_<ContainerAllocator> , typename std::allocator_traits<ContainerAllocator>::template rebind_alloc< ::search_and_rescue::Cell_<ContainerAllocator> >> _cells_type;
  _cells_type cells;





  typedef boost::shared_ptr< ::search_and_rescue::Frontier_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::search_and_rescue::Frontier_<ContainerAllocator> const> ConstPtr;

}; // struct Frontier_

typedef ::search_and_rescue::Frontier_<std::allocator<void> > Frontier;

typedef boost::shared_ptr< ::search_and_rescue::Frontier > FrontierPtr;
typedef boost::shared_ptr< ::search_and_rescue::Frontier const> FrontierConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::search_and_rescue::Frontier_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::search_and_rescue::Frontier_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::search_and_rescue::Frontier_<ContainerAllocator1> & lhs, const ::search_and_rescue::Frontier_<ContainerAllocator2> & rhs)
{
  return lhs.cells == rhs.cells;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::search_and_rescue::Frontier_<ContainerAllocator1> & lhs, const ::search_and_rescue::Frontier_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace search_and_rescue

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::search_and_rescue::Frontier_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::search_and_rescue::Frontier_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::search_and_rescue::Frontier_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::search_and_rescue::Frontier_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::search_and_rescue::Frontier_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::search_and_rescue::Frontier_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::search_and_rescue::Frontier_<ContainerAllocator> >
{
  static const char* value()
  {
    return "1b8456de71852d4b418f0efe52e743ad";
  }

  static const char* value(const ::search_and_rescue::Frontier_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x1b8456de71852d4bULL;
  static const uint64_t static_value2 = 0x418f0efe52e743adULL;
};

template<class ContainerAllocator>
struct DataType< ::search_and_rescue::Frontier_<ContainerAllocator> >
{
  static const char* value()
  {
    return "search_and_rescue/Frontier";
  }

  static const char* value(const ::search_and_rescue::Frontier_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::search_and_rescue::Frontier_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# Frontier.msg\n"
"\n"
"Cell[] cells # List of cells\n"
"================================================================================\n"
"MSG: search_and_rescue/Cell\n"
"# Cell.msg\n"
"\n"
"int32 x\n"
"int32 y\n"
;
  }

  static const char* value(const ::search_and_rescue::Frontier_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::search_and_rescue::Frontier_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.cells);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct Frontier_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::search_and_rescue::Frontier_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::search_and_rescue::Frontier_<ContainerAllocator>& v)
  {
    s << indent << "cells[]" << std::endl;
    for (size_t i = 0; i < v.cells.size(); ++i)
    {
      s << indent << "  cells[" << i << "]: ";
      s << std::endl;
      s << indent;
      Printer< ::search_and_rescue::Cell_<ContainerAllocator> >::stream(s, indent + "    ", v.cells[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // SEARCH_AND_RESCUE_MESSAGE_FRONTIER_H
