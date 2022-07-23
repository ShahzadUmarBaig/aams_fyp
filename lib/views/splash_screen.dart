import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xff3262B7), width: 3),
              ),
              child: Image.asset(
                'assets/images/applogo.png',
                width: 220,
                height: 220,
              ),
            ),
            SizedBox(height: 36),
            Text(
              'An Efficient Attendance System',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w600,
                color: Color(0xff3262B7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
