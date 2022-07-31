part of 'attendance_bloc.dart';

@immutable
abstract class AttendanceEvent {}

class RemoveImage extends AttendanceEvent {}

class AddImage extends AttendanceEvent {}

class OnMarkAttendancePressed extends AttendanceEvent {}

class OnSnackBarClosed extends AttendanceEvent {}
