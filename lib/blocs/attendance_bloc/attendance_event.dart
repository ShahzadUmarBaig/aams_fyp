part of 'attendance_bloc.dart';

@immutable
abstract class AttendanceEvent {}

class RemoveImage extends AttendanceEvent {}

class AddImage extends AttendanceEvent {
  final PickedFile image;
  AddImage(this.image);
}

class OnMarkAttendancePressed extends AttendanceEvent {}

class OnSnackBarClosed extends AttendanceEvent {}
