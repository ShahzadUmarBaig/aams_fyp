part of 'home_bloc.dart';

class HomeState {
  HomeState({
    required this.courses,
    required this.classes,
    required this.attendances,
    required this.user,
  });

  final KtList<Course> courses;
  final KtList<Class> classes;
  final KtList<Attendance> attendances;
  final User? user;

  bool attendanceAlreadyMarked(Class classObject) {
    return attendances.any(
      (attendance) =>
          attendance.classObject == classObject &&
          attendance.uid == u.FirebaseAuth.instance.currentUser!.uid,
    );
  }

  factory HomeState.initial() => HomeState(
        courses: <Course>[].toImmutableList(),
        classes: <Class>[].toImmutableList(),
        attendances: <Attendance>[].toImmutableList(),
        user: null,
      );

  HomeState copyWith({
    KtList<Course>? courses,
    KtList<Class>? classes,
    KtList<Attendance>? attendances,
  }) {
    return HomeState(
      courses: courses ?? this.courses,
      classes: classes ?? this.classes,
      attendances: attendances ?? this.attendances,
      user: user,
    );
  }

  HomeState copyWithUser({User? user}) {
    return HomeState(
      courses: courses,
      classes: classes,
      attendances: attendances,
      user: user,
    );
  }
}
