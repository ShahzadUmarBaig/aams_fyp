import 'dart:io';

import 'package:aams_fyp/blocs/attendance_bloc/attendance_bloc.dart';
import 'package:aams_fyp/blocs/auth_bloc/auth_bloc.dart';
import 'package:aams_fyp/blocs/home_bloc/home_bloc.dart';
import 'package:aams_fyp/constants.dart';
import 'package:aams_fyp/models/class.dart';
import 'package:aams_fyp/services/firebase_service.dart';
import 'package:aams_fyp/views/add_class_screen.dart';
import 'package:aams_fyp/widgets/custom_app_bar.dart';
import 'package:aams_fyp/widgets/image_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AllClassesScreen extends StatelessWidget {
  static const String id = '/all_classes_screen';
  const AllClassesScreen({Key? key}) : super(key: key);

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  bool isClassActive(DateTime startDateTime, DateTime endDateTime) {
    DateTime currentDateTime = DateTime.now();
    int startInt = currentDateTime.compareTo(startDateTime);
    int endInt = currentDateTime.compareTo(endDateTime);
    return startInt >= 0 && endInt <= 0;
  }

  bool isValidClassCode(String classCode) {
    RegExp regExp = RegExp(r'^CSC-[0-9]{2}[S|F]-\d{3}$');
    return regExp.hasMatch(classCode);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (homeContext, state) {
        HomeBloc homeBloc = context.read<HomeBloc>();
        return SafeArea(
          child: Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          itemCount: state.classes.iter.length,
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.15),
                          itemBuilder: (context, index) {
                            Class classObject = state.classes.asList()[index];
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                child: Row(
                                  children: [
                                    SizedBox(width: 16),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          classObject.className,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Start Time: ",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              formatDateTime(
                                                  classObject.startTime),
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(" "),
                                            Text(
                                              TimeOfDay.fromDateTime(
                                                      classObject.startTime)
                                                  .format(context),
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "End Time: ",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              formatDateTime(
                                                  classObject.endTime),
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(" "),
                                            Text(
                                              TimeOfDay.fromDateTime(
                                                      classObject.endTime)
                                                  .format(context),
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    if (isClassActive(classObject.startTime,
                                        classObject.endTime))
                                      if (!state
                                          .attendanceAlreadyMarked(classObject))
                                        MaterialButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              constraints: BoxConstraints(
                                                  maxHeight: 340),
                                              context: context,
                                              builder: (context) {
                                                return BlocProvider.value(
                                                  value:
                                                      BlocProvider.of<HomeBloc>(
                                                          homeContext),
                                                  child: AttendanceSheet(
                                                      classObject: classObject),
                                                );
                                              },
                                            );
                                          },
                                          color: Constants.buttonColor,
                                          shape: CircleBorder(),
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                        ),
                                    if (state
                                        .attendanceAlreadyMarked(classObject))
                                      Container(
                                        margin: EdgeInsets.only(right: 16),
                                        child: Text(
                                          "Marked",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: CustomAppBar(
                      name: "Classes",
                      showActions: true,
                      onPressed: () {
                        Navigator.pushNamed(context, AddClassScreen.id,
                            arguments: homeBloc);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class AttendanceSheet extends StatelessWidget {
  final Class classObject;
  const AttendanceSheet({Key? key, required this.classObject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AuthBloc>.value(
        value: context.read<AuthBloc>(),
        child: BlocProvider(
          create: (context) =>
              AttendanceBloc(context.read<AuthBloc>(), classObject),
          child: BlocConsumer<AttendanceBloc, AttendanceState>(
            listener: (context, state) {
              if (state.isSuccess) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          margin: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: state.file != null
                                  ? FileImage(File(state.file!.path))
                                  : AssetImage(
                                          "assets/images/image_placeholder.jpeg")
                                      as ImageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        if (state.file != null)
                          Positioned(
                            top: -10,
                            right: -25,
                            child: ImageButtonTwo(
                              icon: Icons.close,
                              onPressed: () {
                                context
                                    .read<AttendanceBloc>()
                                    .add(RemoveImage());
                              },
                            ),
                          ),
                        if (state.file == null)
                          Positioned(
                            top: -10,
                            right: -25,
                            child: ImageButtonTwo(
                              icon: Icons.add,
                              onPressed: () {
                                context.read<AttendanceBloc>().add(AddImage());
                              },
                            ),
                          ),
                      ],
                    ),
                    Text(
                      "Please upload your previously registered image and press the button",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    if (state.apiException != null)
                      Text(
                        "FAILED: ${state.apiException!.message}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                    Spacer(),
                    state.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : MaterialButton(
                            onPressed: state.file == null
                                ? null
                                : () => context
                                    .read<AttendanceBloc>()
                                    .add(OnMarkAttendancePressed()),
                            disabledColor: Colors.grey,
                            color: Constants.buttonColor,
                            minWidth: double.infinity,
                            height: 45,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              'Mark Attendance',
                              style: Constants.buttonTextStyle,
                            ),
                          )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
