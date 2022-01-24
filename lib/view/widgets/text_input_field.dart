import 'package:flutter/material.dart';
import 'package:tiktok/constants.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool isObscure;
  const TextInputField(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.icon,
      required this.isObscure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        labelStyle: TextStyle(fontSize: 20),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: borderColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: borderColor)),
      ),
      obscureText: isObscure,
    );
  }
}
