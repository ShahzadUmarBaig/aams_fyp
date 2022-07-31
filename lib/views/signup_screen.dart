import 'dart:io';

import 'package:aams_fyp/views/home_screen.dart';
import 'package:aams_fyp/views/signin_screen.dart';
import 'package:aams_fyp/widgets/image_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import '../constants.dart';

class SignUpScreen extends StatelessWidget {
  static const String id = "/sign-up";

  SignUpScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (authContext, authState) {
        if (authState.user != null) {
          Navigator.pushReplacementNamed(context, HomeScreen.id,
              arguments: context.read<AuthBloc>());
        }
        if (authState.apiException.message.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(authState.apiException.message),
          ));
          authContext.read<AuthBloc>().add(OnApiChanged());
        }
      },
      builder: (authContext, authState) {
        print(authState.user);
        return Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: authState.file != null
                            ? FileImage(File(authState.file!.path))
                            : AssetImage("assets/images/image_placeholder.jpeg")
                                as ImageProvider,
                        foregroundColor: Colors.blue,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: authState.file != null
                            ? ImageButton(
                                icon: Icons.remove_circle_outline_outlined,
                                onPressed: () => context
                                    .read<AuthBloc>()
                                    .add(OnRemoveImage()),
                              )
                            : ImageButton(
                                icon: Icons.add_a_photo,
                                onPressed: () {
                                  context.read<AuthBloc>().add(OnImagePicked());
                                },
                              ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 18),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 21),
                          Text("Create Account",
                              style: Constants.titleTextStyle),
                          SizedBox(height: 21),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (studentId) {
                              if (!authState.isStudentIdValid) {
                                return "Please enter your student ID";
                              }
                              return null;
                            },
                            decoration: Constants.textFieldDecoration.copyWith(
                              hintText: "Type your Student ID",
                              prefixIcon: Icon(
                                Icons.text_fields_outlined,
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ),
                            onChanged: (studentId) {
                              context
                                  .read<AuthBloc>()
                                  .add(OnStudentIdChanged(studentId));
                            },
                          ),
                          SizedBox(height: 24),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (!authState.isEmailValid) {
                                return "Email is not valid";
                              }
                              return null;
                            },
                            decoration: Constants.textFieldDecoration.copyWith(
                              prefixIcon: Icon(
                                Icons.alternate_email,
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ),
                            onChanged: (email) {
                              context.read<AuthBloc>().add(
                                    OnEmailChanged(email),
                                  );
                            },
                          ),
                          SizedBox(height: 24),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (authState.studentName.isEmpty) {
                                return "Student Name is empty";
                              }
                              return null;
                            },
                            decoration: Constants.textFieldDecoration.copyWith(
                              hintText: "Enter your Student Name",
                              prefixIcon: Icon(
                                Icons.alternate_email,
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ),
                            onChanged: (studentName) {
                              context
                                  .read<AuthBloc>()
                                  .add(OnStudentNameChanged(studentName));
                            },
                          ),
                          SizedBox(height: 24),
                          TextFormField(
                            obscureText: true,
                            validator: (value) {
                              if (!authState.isPasswordValid) {
                                return "Password must be alphanumeric";
                              }
                              return null;
                            },
                            decoration: Constants.textFieldDecoration.copyWith(
                              hintText: 'Type your password',
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ),
                            onChanged: (password) {
                              context.read<AuthBloc>().add(
                                    OnPasswordChanged(password),
                                  );
                            },
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
                                TextSpan(
                                    text:
                                        'By Signing up, you\'re agree to our '),
                                TextSpan(
                                  text: ' Terms & Conditions ',
                                  style:
                                      TextStyle(color: Constants.buttonColor),
                                ),
                                TextSpan(text: 'and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style:
                                      TextStyle(color: Constants.buttonColor),
                                ),
                              ])),
                          SizedBox(height: 24),
                          authState.isLoading
                              ? Center(child: CircularProgressIndicator())
                              : MaterialButton(
                                  onPressed: authState.isValid
                                      ? () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context
                                                .read<AuthBloc>()
                                                .add(OnSignUp());
                                          }
                                        }
                                      : null,
                                  disabledColor: Colors.grey.shade400,
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
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
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
