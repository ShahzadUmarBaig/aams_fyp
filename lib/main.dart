import 'package:aams_fyp/blocs/auth_bloc/auth_bloc.dart';
import 'package:aams_fyp/route_generator.dart';
import 'package:aams_fyp/services/sp_service.dart';
import 'package:aams_fyp/views/home_screen.dart';
import 'package:aams_fyp/views/signin_screen.dart';
import 'package:aams_fyp/views/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SPService().init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              debugShowCheckedModeBanner: true,
              title: 'Efficient Attendance System',
              home: SignInScreen(),
              onGenerateRoute: RouteGenerator.generateRoute,
            );
          }

          return MaterialApp(
            title: 'Efficient Attendance System',
            theme: ThemeData(primarySwatch: Colors.blue),
            home: SplashScreen(),
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        },
      ),
    );
  }
}
