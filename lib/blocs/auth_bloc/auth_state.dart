part of 'auth_bloc.dart';

// add isLoading variable in AuthState

class AuthState {
  AuthState({
    required this.file,
    required this.email,
    required this.password,
    required this.studentId,
    required this.studentName,
    required this.isLoading,
    required this.user,
    required this.apiException,
  });

  final PickedFile? file;
  final String email;
  final String password;
  final String studentId;
  final String studentName;
  final bool isLoading;
  final User? user;
  final ApiException apiException;

  bool get isValid {
    return email.isNotEmpty &&
        password.isNotEmpty &&
        studentId.isNotEmpty &&
        studentName.isNotEmpty &&
        file != null;
  }

  factory AuthState.initial() => AuthState(
        file: null,
        email: "",
        password: "",
        studentId: "",
        studentName: "",
        isLoading: false,
        user: null,
        apiException: ApiException(""),
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
    String? email,
    String? password,
    String? studentId,
    String? studentName,
    bool? isLoading,
    User? user,
    ApiException? apiException,
  }) {
    return AuthState(
      file: file,
      email: email ?? this.email,
      password: password ?? this.password,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      apiException: apiException ?? this.apiException,
    );
  }

  AuthState copyWithUser({User? user}) {
    return AuthState(
      user: user,
      file: file,
      email: email,
      password: password,
      studentId: studentId,
      studentName: studentName,
      isLoading: isLoading,
      apiException: apiException,
    );
  }

  AuthState copyWithImage({PickedFile? file}) {
    return AuthState(
      file: file,
      email: email,
      password: password,
      studentId: studentId,
      studentName: studentName,
      isLoading: isLoading,
      user: user,
      apiException: apiException,
    );
  }
}
