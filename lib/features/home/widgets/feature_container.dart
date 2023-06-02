import 'package:flutter/material.dart';

class FeatureContainer extends StatelessWidget {
  const FeatureContainer({
    Key? key,
    required this.color,
    required this.headingText,
    required this.subHeadingText,
  }) : super(key: key);

  final Color color;
  final String headingText;
  final String subHeadingText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0).copyWith(
          left: 15,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headingText,
                style: const TextStyle(
                  fontFamily: 'Rubik',
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                subHeadingText,
                style: const TextStyle(
                  fontFamily: 'Rubik',
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
