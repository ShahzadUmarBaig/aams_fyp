import 'package:aams_fyp/blocs/auth_bloc/auth_bloc.dart';
import 'package:aams_fyp/blocs/home_bloc/home_bloc.dart';
import 'package:aams_fyp/views/all_classes_screen.dart';

import 'package:aams_fyp/views/all_courses_screen.dart';
import 'package:aams_fyp/views/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../widgets/custom_date_picker.dart';

class HomeScreen extends StatelessWidget {
  static const String id = "/home";
  HomeScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: DrawerWidget(),
          body: SafeArea(
            child: ListView(
              children: [
                Column(
                  children: [
                    AppBarWidget(scaffoldKey: _scaffoldKey),
                    TableComplexExample(
                      () {},
                      kLastDay: DateTime.now(),
                      kFirstDay: DateTime.now(),
                    ),
                    Container(
                      height: 80,
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Total Working Days",
                            style: TextStyle(
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xff6C5DDC),
                            ),
                            child: Text(
                              "24",
                              style: TextStyle(
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomContainer(
                            title: 'Total Classes',
                            text: state.classes.iter.length.toString(),
                            colorValue: 0xffE94D90),
                        SizedBox(width: 24),
                        CustomContainer(
                            title: 'Total Present',
                            text: state.attendances.iter.length.toString(),
                            colorValue: 0xff21D1FF),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Drawer(
          backgroundColor: Color(0xff6150D1),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Color(0xff6150D1)),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 32, horizontal: 21),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Icon(
                          Icons.person,
                          color: Color(0xff6150D1),
                          size: 42,
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.user != null
                                ? state.user!.studentName
                                : "Anonymous",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'poppins',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 34),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      child: const Text(
                        'Classes',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AllClassesScreen.id,
                          arguments: context.read<HomeBloc>(),
                        );
                      },
                    ),
                    TextButton(
                      child: const Text(
                        'Courses',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AllCourseScreen.id,
                          arguments: context.read<HomeBloc>(),
                        );
                      },
                    ),
                    TextButton(
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        context.read<AuthBloc>().add(OnUserChanged(null));
                        Navigator.pushReplacementNamed(
                            context, SignInScreen.id);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.title,
    required this.text,
    required this.colorValue,
  }) : super(key: key);
  final String title;
  final String text;
  final int colorValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container(
          width: 167,
          height: 202,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Color(colorValue),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 14,
                left: 12,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Positioned(
                bottom: -24,
                right: 15,
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 92,
                    color: Colors.white,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key, required this.scaffoldKey}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;

  String getMonthName(DateTime date) {
    var month = date.month;
    var year = date.year;
    var monthName = DateFormat.MMMM().format(DateTime(year, month));
    return '$monthName, $year';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 92,
            decoration: BoxDecoration(
              color: Color(0xff6C5DDC),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
            ),
            child: Row(
              children: [
                MaterialButton(
                  onPressed: () {
                    scaffoldKey.currentState!.openDrawer();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(42),
                  ),
                  minWidth: 0,
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.21),
                // Spacer(),
                Text(
                  "Attendance",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'poppins',
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Positioned(
            bottom: 2,
            left: 14,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.92,
              height: 52,
              padding: EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(blurRadius: 0.2, color: Colors.black12)
                  ]),
              child: Row(
                children: [
                  Spacer(),
                  Text(
                    "${getMonthName(DateTime.now())}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins'),
                  ),
                  Spacer(),
                  // Icon(
                  //   Icons.arrow_forward_ios,
                  //   color: Color(0xff5E4CCD),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
