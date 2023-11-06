
import 'package:e_commerce_app/screens/auth/screens/sign_up_screen.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';

class SignInBottomTitle extends StatelessWidget {
  const SignInBottomTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Are you new here?",
          style: TextStyle(color: Colors.black),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, SignUpScreen.routeName);
          },
          child: const Text(
            "SignUp",
            style: TextStyle(
                color: GlobalVariables.primaryColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
