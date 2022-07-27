import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String name;

  final bool showActions;
  final Function()? onPressed;
  CustomAppBar({
    Key? key,
    required this.name,
    this.showActions = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 92,
            decoration: BoxDecoration(
              color: Color(0xff6C5DDC),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
            ),
            child: Row(
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(42),
                  ),
                  minWidth: 0,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.21),
                // Spacer(),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'poppins',
                  ),
                ),
                Spacer(),
                if (showActions)
                  MaterialButton(
                    onPressed: onPressed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(42),
                    ),
                    minWidth: 0,
                    child: Icon(
                      Icons.golf_course,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
