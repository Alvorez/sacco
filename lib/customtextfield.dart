import 'package:flutter/material.dart';
import 'package:sacco_teller/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool isPassword;
  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.isPassword = true,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: TextField(
        obscureText: isPassword,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              color: appWhite,
              width: 50,
            ),
          ),
        ),
        //obscureText: isPassword,
      ),
    );
  }
}
