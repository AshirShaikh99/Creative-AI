import 'package:flutter/material.dart';
import 'package:social_networking/theme/theme_imports.dart';

class AuthButton extends StatefulWidget {
  const AuthButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);
  final String label;
  final Function onPressed;
  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onPressed();
      },
      child: Text(
        widget.label,
        style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 1.0),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(370, 50),
        primary: Pallete.floatingActionButton,
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
