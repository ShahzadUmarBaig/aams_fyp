import 'dart:async';

import 'package:aams_fyp/blocs/auth_bloc/auth_bloc.dart';
import 'package:aams_fyp/models/attendance.dart';
import 'package:aams_fyp/models/class.dart';
import 'package:aams_fyp/models/course.dart';
import 'package:aams_fyp/models/user.dart';
import 'package:aams_fyp/services/firebase_service.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as u;
import 'package:kt_dart/kt.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  StreamSubscription? authBlocStream;
  StreamSubscription? courseStream;
  StreamSubscription? classStream;
  StreamSubscription? attendanceStream;
  StreamSubscription? userStream;

  FirebaseService _firebaseService = FirebaseService();
  HomeBloc(AuthBloc authBloc) : super(HomeState.initial()) {
    userStream = _firebaseService.userStream().listen((user) {
      if (!isClosed) add(AddUser(user));
    });

    courseStream = _firebaseService.getAllCourses().listen((courses) {
      if (!isClosed) add(AddCourseList(courses));
    });
    classStream = _firebaseService.getAllClasses().listen((classes) {
      if (!isClosed) add(AddClassList(classes));
    });
    attendanceStream =
        _firebaseService.getAllAttendance().listen((attendances) {
      if (!isClosed) add(AddAttendanceList(attendances));
    });

    on<OnSearchInputChanged>(
        (event, emit) => emit(state.copyWith(searchInput: event.searchInput)));
    on<OnCourseChanged>((event, emit) {
      emit(state.copyWith(selectedCourse: event.course));
    });

    on<AddUser>((event, emit) => emit(state.copyWithUser(user: event.user)));

    on<AddAttendanceList>((event, emit) {
      emit(state.copyWith(attendances: event.attendance.toImmutableList()));
    });

    on<RefreshClassList>((event, emit) {
      List<Class> allClasses = state.classes.asList();
      emit(state.copyWith(classes: <Class>[].toImmutableList()));
      emit(state.copyWith(classes: allClasses.toImmutableList()));
    });

    // write AddClassList event
    on<AddClassList>((event, emit) {
      emit(state.copyWith(classes: event.classes.toImmutableList()));
    });

    on<AddCourseList>((event, emit) {
      emit(state.copyWith(courses: event.courses.toImmutableList()));
    });
  }

  @override
  Future<void> close() {
    authBlocStream?.cancel();
    courseStream?.cancel();
    classStream?.cancel();
    attendanceStream?.cancel();
    return super.close();
  }
}
