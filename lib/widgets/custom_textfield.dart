import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool autofocus;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.maxLines = 1,
      this.autofocus = false
      });

  OutlineInputBorder borderDecoration() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
            const BorderSide(width: 0.7, color: GlobalVariables.primaryColor));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      autofocus: autofocus,
      decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          border: borderDecoration(),
          enabledBorder: borderDecoration()),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Enter your $hintText";
        }
        return null;
      },
    );
  }
}
