part of 'home_bloc.dart';

class HomeState {
  HomeState({
    required this.courses,
    required this.classes,
    required this.attendances,
    required this.user,
    required this.selectedCourse,
    required this.searchInput,
  });

  final KtList<Course> courses;
  final KtList<Class> classes;
  final KtList<Attendance> attendances;
  final Course? selectedCourse;
  final User? user;
  final String searchInput;

  bool attendanceAlreadyMarked(Class classObject) {
    print(attendances);
    return attendances.any(
      (attendance) {
        return attendance.classObject == classObject &&
            attendance.uid == u.FirebaseAuth.instance.currentUser!.uid;
      },
    );
  }

  List<Class> get classesFiltered {
    if (searchInput.isEmpty) return classes.asList();
    return classes
        .asList()
        .where(
          (classObject) => classObject.className
              .toLowerCase()
              .contains(searchInput.toLowerCase()),
        )
        .toList();
  }

  List<Class> get getExistingClasses {
    return classes
        .asList()
        .where((element) => element.courseName == selectedCourse!.courseName)
        .toList();
  }

  List<Course> get convertedCoursesList {
    return courses.asList();
  }

  factory HomeState.initial() => HomeState(
        courses: <Course>[].toImmutableList(),
        classes: <Class>[].toImmutableList(),
        attendances: <Attendance>[].toImmutableList(),
        selectedCourse: null,
        user: null,
        searchInput: "",
      );

  HomeState copyWith({
    KtList<Course>? courses,
    KtList<Class>? classes,
    KtList<Attendance>? attendances,
    Course? selectedCourse,
    String? searchInput,
  }) {
    return HomeState(
      courses: courses ?? this.courses,
      classes: classes ?? this.classes,
      attendances: attendances ?? this.attendances,
      selectedCourse: selectedCourse ?? this.selectedCourse,
      user: user,
      searchInput: searchInput ?? this.searchInput,
    );
  }

  HomeState copyWithUser({User? user}) {
    return HomeState(
      courses: courses,
      classes: classes,
      attendances: attendances,
      user: user,
      selectedCourse: selectedCourse,
      searchInput: searchInput,
    );
  }
}
