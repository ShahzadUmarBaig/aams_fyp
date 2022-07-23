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
      if (user != null) {
        add(OnUserChanged(user));
      } else {
        add(OnUserChanged(null));
      }
    });

    on<OnImagePicked>((event, emit) => emit(state.copyWith(file: event.file)));
    on<OnRemoveImage>((event, emit) => emit(state.copyWith(file: null)));
    on<OnEmailChanged>((event, emit) =>
        emit(state.copyWith(email: event.email, file: state.file)));
    on<OnPasswordChanged>((event, emit) =>
        emit(state.copyWith(password: event.password, file: state.file)));
    on<OnStudentIdChanged>((event, emit) =>
        emit(state.copyWith(studentId: event.studentId, file: state.file)));
    on<OnSignUp>((event, emit) async {
      emit(state.copyWith(isLoading: true, file: state.file));
      try {
        await _apiService.registerUser(state.studentId, state.file!.path);
        await _apiService.signUpUser(state.email, state.password);
        FirebaseService();
        emit(state.copyWith(isLoading: false));
      } on ApiException catch (e) {
        emit(state.copyWith(isLoading: false, file: state.file));
      }
      emit(state.copyWith(isLoading: false, file: state.file));
    });

    on<OnSignIn>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        await _apiService.signInWithEmailAndPassword(
            state.email, state.password);
        emit(state.copyWith(isLoading: false));
      } on ApiException catch (e) {
        emit(state.copyWith(isLoading: false));
      }
      emit(state.copyWith(isLoading: false));
    });

    on<OnUserChanged>((event, emit) => emit(state.copyWith(user: event.user)));
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
