import 'package:flutter/material.dart';
import 'package:todo_app/my_theme.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  const CustomTextFormField(
      {super.key,
      required this.label,
      required this.controller,
      this.obscureText = false,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: obscureText,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.redColor)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.redColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.greyColor)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.greyColor)),
            label: Text(label),
            labelStyle: TextStyle(color: AppTheme.greyColor, fontSize: 20)));
  }
}
