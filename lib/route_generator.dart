import 'package:aams_fyp/views/home_screen.dart';
import 'package:flutter/material.dart';

import 'views/login_screen.dart';
import 'views/register_screen.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.id:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case HomeScreen.id:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case RegisterScreen.id:
        return MaterialPageRoute(builder: (context) => RegisterScreen());

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
