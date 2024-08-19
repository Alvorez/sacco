import 'package:flutter/material.dart';
import 'package:sacco_teller/constants.dart';

class CustomText extends StatelessWidget {
  final String label;
  final Color labelColor;
  final double fontSize;
  final FontWeight fontWeight;
  const CustomText(String s,
      {super.key,
      required this.label,
      this.labelColor = appWhite,
      this.fontSize = 20,
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        label,
        style: TextStyle(
            color: labelColor, fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }
}

