part of 'attendance_bloc.dart';

class AttendanceState {
  final PickedFile? file;
  final bool isLoading;
  final bool isSuccess;
  final ApiException? apiException;

  AttendanceState({
    required this.file,
    required this.isLoading,
    required this.isSuccess,
    required this.apiException,
  });

  factory AttendanceState.initial() => AttendanceState(
        file: null,
        isLoading: false,
        isSuccess: false,
        apiException: null,
      );

  AttendanceState copyWith({
    bool? isLoading,
    bool? isSuccess,
    ApiException? apiException,
    HomeState? authState,
  }) =>
      AttendanceState(
        file: file,
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,
        apiException: apiException ?? this.apiException,
      );

  AttendanceState copyWithImage({PickedFile? file}) => AttendanceState(
        file: file,
        isLoading: isLoading,
        isSuccess: isSuccess,
        apiException: apiException,
      );
}
