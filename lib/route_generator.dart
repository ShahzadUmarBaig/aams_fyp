import 'package:aams_fyp/blocs/auth_bloc/auth_bloc.dart';
import 'package:aams_fyp/blocs/home_bloc/home_bloc.dart';
import 'package:aams_fyp/views/add_course_screen.dart';
import 'package:aams_fyp/views/all_courses_screen.dart';
import 'package:aams_fyp/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'views/signin_screen.dart';
import 'views/signup_screen.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SignInScreen.id:
        return MaterialPageRoute(builder: (context) => SignInScreen());
      case HomeScreen.id:
        AuthBloc authBloc = settings.arguments as AuthBloc;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => HomeBloc(authBloc),
            child: HomeScreen(),
          ),
        );
      case SignUpScreen.id:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case AllCourseScreen.id:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<HomeBloc>.value(
            value: settings.arguments as HomeBloc,
            child: AllCourseScreen(),
          ),
        );

      case AddCourseScreen.id:
        return MaterialPageRoute(builder: (context) => AddCourseScreen());

      default:
        return MaterialPageRoute(builder: (context) => _errorRoute());
    }
  }

  static Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error Route"),
      ),
      body: Center(
        child: Text("Error Route"),
      ),
    );
  }
}
