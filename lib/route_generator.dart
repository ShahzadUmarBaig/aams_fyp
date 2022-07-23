import 'package:aams_fyp/views/home_screen.dart';
import 'package:flutter/material.dart';

import 'views/signin_screen.dart';
import 'views/signup_screen.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SignInScreen.id:
        return MaterialPageRoute(builder: (context) => SignInScreen());
      case HomeScreen.id:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case SignUpScreen.id:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
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
