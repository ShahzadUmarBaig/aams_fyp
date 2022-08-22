import 'dart:async';

import 'package:aams_fyp/blocs/auth_bloc/auth_bloc.dart';
import 'package:aams_fyp/blocs/home_bloc/home_bloc.dart';
import 'package:aams_fyp/models/class.dart';
import 'package:aams_fyp/models/course.dart';
import 'package:aams_fyp/models/user.dart';
import 'package:aams_fyp/services/api_service.dart';
import 'package:aams_fyp/services/firebase_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  ApiService _apiService = ApiService();
  FirebaseService firebaseService = FirebaseService();

  AttendanceBloc(User user, Class classObject)
      : super(AttendanceState.initial()) {
    on<RemoveImage>((event, emit) {
      emit(state.copyWithImage(file: null));
    });

    on<AddImage>((event, emit) async {
      PickedFile? image = await ImagePicker()
          .getImage(source: ImageSource.camera, imageQuality: 80);

      if (image != null) {
        PickedFile compressedFile = PickedFile(
            (await FlutterNativeImage.compressImage(image.path, quality: 90))
                .path);
        emit(state.copyWithImage(file: compressedFile));
      }
    });

    on<OnMarkAttendancePressed>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        await _apiService.checkWifiName();
        await _apiService.verifyUser(user.studentId, state.file!.path);
        await firebaseService.createAttendance(classObject: classObject);
        emit(state.copyWith(isSuccess: true));
      } on ApiException catch (e) {
        emit(state.copyWith(isLoading: false, apiException: e));
      }
    });

    on<OnSnackBarClosed>((event, emit) {
      emit(state.copyWith(isLoading: false, apiException: null));
    });
  }
}
