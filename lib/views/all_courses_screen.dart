import 'package:aams_fyp/blocs/home_bloc/home_bloc.dart';
import 'package:aams_fyp/views/add_course_screen.dart';
import 'package:aams_fyp/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCourseScreen extends StatelessWidget {
  static const String id = "/all-course-screen";
  const AllCourseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
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
                          itemCount: state.courses.iter.length,
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.15),
                          itemBuilder: (context, index) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                child: ListTile(
                                  title: Text(
                                      state.courses.asList()[index].courseName),
                                  subtitle: Text(state.courses
                                      .asList()[index]
                                      .courseInstructor),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: CustomAppBar(
                      name: "Courses",
                      showActions: true,
                      onPressed: () {
                        Navigator.pushNamed(context, AddCourseScreen.id);
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
