part of 'auth_bloc.dart';

// add isLoading variable in AuthState

class AuthState {
  AuthState({
    required this.file,
    required this.email,
    required this.password,
    required this.studentId,
    required this.isLoading,
    required this.user,
  });

  final PickedFile? file;
  final String email;
  final String password;
  final String studentId;
  final bool isLoading;
  final User? user;

  bool get isValid {
    return email.isNotEmpty &&
        password.isNotEmpty &&
        studentId.isNotEmpty &&
        file != null;
  }

  factory AuthState.initial() => AuthState(
        file: null,
        email: "",
        password: "",
        studentId: "",
        isLoading: false,
        user: null,
      );

  bool get isStudentIdValid {
    return studentId.isNotEmpty;
  }

  bool get isEmailValid {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool get isPasswordValid {
    return password.length >= 8 &&
        RegExp(r'^(?=.*?[a-zA-Z])(?=.*?[0-9])').hasMatch(password);
  }

  AuthState copyWith({
    PickedFile? file,
    String? email,
    String? password,
    String? studentId,
    bool? isLoading,
    User? user,
  }) {
    return AuthState(
      file: file,
      email: email ?? this.email,
      password: password ?? this.password,
      studentId: studentId ?? this.studentId,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
    );
  }
}
