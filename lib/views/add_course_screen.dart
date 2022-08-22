import 'package:aams_fyp/constants.dart';
import 'package:aams_fyp/services/firebase_service.dart';
import 'package:aams_fyp/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AddCourseScreen extends StatefulWidget {
  static const String id = "/add-course-screen";
  AddCourseScreen({Key? key}) : super(key: key);

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final TextEditingController _courseNameController = TextEditingController();

  final TextEditingController _courseInstructorController =
      TextEditingController();

  final TextEditingController _courseClasses = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              CustomAppBar(name: "Add Course"),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (value) {},
                      decoration: Constants.textFieldDecoration.copyWith(
                        hintText: "Course Name",
                        prefixIcon: Icon(
                          Icons.text_fields_outlined,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                      controller: _courseNameController,
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (studentId) {},
                      decoration: Constants.textFieldDecoration.copyWith(
                        hintText: "Course Instructor",
                        prefixIcon: Icon(
                          Icons.text_fields_outlined,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                      controller: _courseInstructorController,
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (studentId) {},
                      decoration: Constants.textFieldDecoration.copyWith(
                        hintText: "Course Classes",
                        prefixIcon: Icon(
                          Icons.text_fields_outlined,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                      controller: _courseClasses,
                    ),
                    SizedBox(height: 24),
                    _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : MaterialButton(
                            onPressed: () {
                              setState(() {
                                _isLoading = true;
                              });
                              FirebaseService()
                                  .createCourse(
                                courseClasses: _courseClasses.text,
                                courseInstructor:
                                    _courseInstructorController.text,
                                courseName: _courseNameController.text,
                              )
                                  .then((value) {
                                setState(() {
                                  _isLoading = false;
                                });
                                Navigator.pop(context);
                              });
                            },
                            color: Constants.buttonColor,
                            minWidth: double.infinity,
                            height: 45,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              'Add',
                              style: Constants.buttonTextStyle,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
