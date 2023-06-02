import 'package:flutter/material.dart';
import 'package:social_networking/theme/theme_imports.dart';

class AuthField extends StatefulWidget {
  const AuthField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.color,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final Color color;
  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontFamily: 'Rubik',
      ),
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontFamily: 'Rubik',
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Pallete.border,
            width: 3.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: widget.color,
            width: 0.5,
          ),
        ),
        contentPadding: const EdgeInsets.all(15),
      ),
    );
  }
}
