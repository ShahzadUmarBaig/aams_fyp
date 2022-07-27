part of 'home_bloc.dart';

class HomeState {
  HomeState({
    required this.courses,
    required this.classes,
  });

  final KtList<Course> courses;
  final KtList<Class> classes;

  factory HomeState.initial() => HomeState(
        courses: <Course>[].toImmutableList(),
        classes: <Class>[].toImmutableList(),
      );

  // write copyWith
  HomeState copyWith({
    KtList<Course>? courses,
    KtList<Class>? classes,
  }) {
    return HomeState(
      courses: courses ?? this.courses,
      classes: classes ?? this.classes,
    );
  }
}
