import 'package:flutter/material.dart';

class Constants {
  static const buttonColor = Color(0xff3262B7);
  static const titleTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const buttonTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static final textFieldDecoration = InputDecoration(
    fillColor: Colors.black.withOpacity(0.05),
    filled: true,
    hintText: 'Type your email',
    hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 0,
        color: Colors.black.withOpacity(0.08),
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Colors.blue,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
