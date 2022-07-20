import 'package:aams_fyp/views/signin_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SignUpScreen extends StatelessWidget {
  static const String id = "/sign-up";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 72),
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xff3262B7), width: 3),
                  ),
                  child: Image.asset(
                    'assets/images/signup.jpg',
                    width: 170,
                    height: 170,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 21),
                      Text(
                        "Create Account",
                        style: Constants.titleTextStyle,
                      ),
                      SizedBox(height: 21),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: Constants.textFieldDecoration.copyWith(
                          prefixIcon: Icon(
                            Icons.alternate_email,
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        obscureText: true,
                        decoration: Constants.textFieldDecoration.copyWith(
                          hintText: 'Type your password',
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black.withOpacity(0.2),
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                            TextSpan(text: 'By Signing up, you\'re agree to our '),
                            TextSpan(
                              text: ' Terms & Conditions ',
                              style: TextStyle(color: Constants.buttonColor),
                            ),
                            TextSpan(text: 'and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(color: Constants.buttonColor),
                            ),
                          ])),
                      SizedBox(height: 24),
                      MaterialButton(
                        onPressed: () {},
                        color: Constants.buttonColor,
                        minWidth: double.infinity,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 48,
                        child: Text(
                          'Continue',
                          style: Constants.buttonTextStyle,
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Joined us Before?",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.2),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          MaterialButton(
                            onPressed: () => Navigator.pushReplacementNamed(
                              context,
                              SignInScreen.id,
                            ),
                            minWidth: 62,
                            padding: EdgeInsets.all(0),
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Constants.buttonColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
