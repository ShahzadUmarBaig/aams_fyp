part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class AddCourseList extends HomeEvent {
  final List<Course> courses;
  AddCourseList(this.courses);
}

class AddClassList extends HomeEvent {
  final List<Class> classes;
  AddClassList(this.classes);
}

class AddAttendanceList extends HomeEvent {
  final List<Attendance> attendance;
  AddAttendanceList(this.attendance);
}

class AddUser extends HomeEvent {
  final User user;
  AddUser(this.user);
}

class OnCourseChanged extends HomeEvent {
  final Course course;
  OnCourseChanged(this.course);
}

class RefreshClassList extends HomeEvent {}

class OnSearchInputChanged extends HomeEvent {
  final String searchInput;
  OnSearchInputChanged(this.searchInput);
}
