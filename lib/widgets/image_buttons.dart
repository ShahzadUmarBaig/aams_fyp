import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;

  const ImageButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 45,
      shape: CircleBorder(),
      color: Colors.red,
      child: Icon(icon, color: Colors.white),
      onPressed: onPressed,
    );
  }
}

class ImageButtonTwo extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;

  const ImageButtonTwo({Key? key, required this.icon, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 24,
      shape: CircleBorder(),
      color: Colors.white,
      elevation: 5,
      child: Icon(icon, color: Colors.red, size: 16),
      onPressed: onPressed,
    );
  }
}
