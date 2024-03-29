import 'package:aams_fyp/blocs/auth_bloc/auth_bloc.dart';
import 'package:aams_fyp/views/home_screen.dart';
import 'package:aams_fyp/views/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';

class SignInScreen extends StatelessWidget {
  static const String id = "/sign-in";
  SignInScreen({Key? key}) : super(key: key);

  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (authContext, authState) {
        if (authState.user != null) {
          Navigator.pushReplacementNamed(
            context,
            HomeScreen.id,
            arguments: context.read<AuthBloc>(),
          );
        }
      },
      builder: (authContext, authState) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 72),
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
                  SizedBox(height: 21),
                  Text(
                    'Automated Attendance',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff3262B7),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 18),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 21),
                          TextFormField(
                            onChanged: (email) {
                              authContext
                                  .read<AuthBloc>()
                                  .add(OnEmailChanged(email));
                            },
                            validator: (email) {
                              if (!authState.isEmailValid) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
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
                            onChanged: (password) {
                              authContext
                                  .read<AuthBloc>()
                                  .add(OnPasswordChanged(password));
                            },
                            validator: (password) {
                              if (!authState.isPasswordValid) {
                                return 'Password is required';
                              }
                              return null;
                            },
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
                          authState.isLoading
                              ? Center(child: CircularProgressIndicator())
                              : MaterialButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      authContext
                                          .read<AuthBloc>()
                                          .add(OnSignIn());
                                    }
                                  },
                                  color: Constants.buttonColor,
                                  minWidth: double.infinity,
                                  height: 45,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    'Login',
                                    style: Constants.buttonTextStyle,
                                  ),
                                ),
                          SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "New to App? ",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.2),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              MaterialButton(
                                onPressed: () => Navigator.pushReplacementNamed(
                                  context,
                                  SignUpScreen.id,
                                ),
                                minWidth: 62,
                                padding: EdgeInsets.all(0),
                                visualDensity: VisualDensity.compact,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                child: Text(
                                  'Register',
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
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.18,
        child: Stack(
          children: [
            Container(
              width: 130,
              height: 130,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  'User',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                  ),
                ),
              ),
            ),
            Positioned(
              right: -8,
              bottom: 8,
              child: MaterialButton(
                onPressed: () async {},
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(0.0),
                child: Ink(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xff3531EC),
                        Color(0xff873FA9),
                      ],
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(0),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
