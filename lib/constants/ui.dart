import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'constants.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: Text(
        "Creative AI",
        style: TextStyle(
          fontFamily: 'Rubik',
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: Pallete.backgroundColor,
    );
  }
}
