import 'dart:async';

import 'package:aams_fyp/services/api_service.dart';
import 'package:aams_fyp/services/firebase_service.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  ApiService _apiService = ApiService();
  StreamSubscription? _authSubscription;

  AuthBloc() : super(AuthState.initial()) {
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      print("========= USER CHANGES==========");
      print(user);
      add(OnUserChanged(user));
    });

    on<OnImagePicked>(
        (event, emit) => emit(state.copyWithImage(file: event.file)));
    on<OnRemoveImage>((event, emit) => emit(state.copyWithImage(file: null)));

    on<OnEmailChanged>(
        (event, emit) => emit(state.copyWith(email: event.email)));
    on<OnPasswordChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));
    on<OnStudentIdChanged>(
        (event, emit) => emit(state.copyWith(studentId: event.studentId)));

    on<OnApiChanged>(
        (event, emit) => emit(state.copyWith(apiException: ApiException(""))));

    on<OnUserChanged>(
        (event, emit) => emit(state.copyWithUser(user: event.user)));

    on<OnStudentNameChanged>(
        (event, emit) => emit(state.copyWith(studentName: event.studentName)));

    on<OnSignUp>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        await _apiService.registerUser(state.studentId, state.file!.path);
        await _apiService.signUpUser(state.email, state.password);
        FirebaseService firebaseService = FirebaseService();
        firebaseService.createUser(
            studentName: state.studentName,
            studentId: state.studentId,
            email: state.email);
        emit(state.copyWith(isLoading: false));
        emit(state.copyWithImage(file: null));
      } on ApiException catch (e) {
        emit(state.copyWith(isLoading: false, apiException: e));
      }
      emit(state.copyWith(isLoading: false));
    });

    on<OnSignIn>((event, emit) async {
      try {
        emit(state.copyWith(isLoading: true));
        await _apiService.signInWithEmailAndPassword(
            state.email, state.password);
        FirebaseService firebaseService = FirebaseService();
        emit(state.copyWith(isLoading: false));
      } on ApiException catch (e) {
        emit(state.copyWith(isLoading: false));
      }
    });
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
