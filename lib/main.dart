import 'package:aams_fyp/route_generator.dart';
import 'package:aams_fyp/views/home_screen.dart';
import 'package:aams_fyp/views/signin_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
