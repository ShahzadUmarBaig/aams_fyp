part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class OnImagePicked extends AuthEvent {
  final PickedFile file;
  OnImagePicked(this.file);
}

class OnEmailChanged extends AuthEvent {
  final String email;
  OnEmailChanged(this.email);
}

class OnPasswordChanged extends AuthEvent {
  final String password;
  OnPasswordChanged(this.password);
}

class OnStudentIdChanged extends AuthEvent {
  final String studentId;
  OnStudentIdChanged(this.studentId);
}

class OnRemoveImage extends AuthEvent {}

class OnSignUp extends AuthEvent {}

// on sign in pressed
class OnSignIn extends AuthEvent {}

// on user changed
class OnUserChanged extends AuthEvent {
  final User? user;
  OnUserChanged(this.user);
}

class OnApiChanged extends AuthEvent {}

class OnStudentNameChanged extends AuthEvent {
  final String studentName;
  OnStudentNameChanged(this.studentName);
}
