import 'package:flutter/material.dart';
import 'package:sacco_teller/constants.dart';

class CustomTextWidget extends StatelessWidget {
  final String? hint;
  final IconData? icon;
  final bool? hideText;
  final bool ispassword;
  const CustomTextWidget(
    String s, {
    super.key,
    required String label,
    this.hint,
    this.icon,
    this.hideText = false,
    this.ispassword = false,
    required TextEditingController controller,
    dynamic required,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: appWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: primaryColor, width: 2.0),
        ),
        labelText: hint,
        labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
        prefixIcon: Icon(icon),
        suffixIcon: ispassword
            ? const Icon(Icons.visibility)
            : const SizedBox(
                height: 10,
                width: 10,
              ),
      ),
      controller: TextEditingController(),
      obscureText: hideText!,
    );
  }
}
