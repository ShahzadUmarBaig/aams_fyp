import 'dart:async';

import 'package:aams_fyp/blocs/auth_bloc/auth_bloc.dart';
import 'package:aams_fyp/models/class.dart';
import 'package:aams_fyp/models/course.dart';
import 'package:aams_fyp/services/firebase_service.dart';
import 'package:bloc/bloc.dart';
import 'package:kt_dart/kt.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  StreamSubscription? authBlocStream;
  StreamSubscription? courseStream;
  StreamSubscription? classStream;
  FirebaseService _firebaseService = FirebaseService();
  HomeBloc(AuthBloc authBloc) : super(HomeState.initial()) {
    authBlocStream = authBloc.stream.listen((authState) {});
    courseStream = _firebaseService.getAllCourses().listen((courses) {
      add(AddCourseList(courses));
    });
    classStream = _firebaseService.getAllClasses().listen((classes) {
      add(AddClassList(classes));
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
    return super.close();
  }
}
