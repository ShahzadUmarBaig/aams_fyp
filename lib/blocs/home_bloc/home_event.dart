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
