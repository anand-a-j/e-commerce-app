import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool autofocus;
  final TextInputType inputType;
  final bool isPass;
  final bool isEnabled;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.maxLines = 1,
      this.autofocus = false,
      this.inputType = TextInputType.text,
      this.isPass = false,
      this.isEnabled = false});

  OutlineInputBorder borderDecoration() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:
          const BorderSide(width: 0.7, color: GlobalVariables.primaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, auth, child) {
      return TextFormField(
        controller: controller,
        maxLines: maxLines,
        autofocus: autofocus,
        keyboardType: inputType,
        readOnly: isEnabled,
        obscureText: isPass == true
            ? auth.isPass != true
                ? true
                : false
            : false,
        decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            border: borderDecoration(),
            enabledBorder: borderDecoration(),
            suffixIcon: isPass
                ? IconButton(
                    onPressed: () {
                      if (auth.isPass == false) {
                        auth.setIsPass(true);
                      } else {
                        auth.setIsPass(false);
                      }
                    },
                    icon: Icon(
                      auth.isPass != true ? Icons.visibility_off : Icons.visibility,
                    ),
                  )
                : null),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Enter your $hintText";
          }
          return null;
        },
      );
    });
  }
}
