import 'package:e_commerce_app/screens/auth/screens/sign_in_screen.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';

class SignUpBottomTitle extends StatelessWidget {
  const SignUpBottomTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already Signin?",
          style: TextStyle(color: Colors.black),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, SignInScreen.routeName);
          },
          child: const Text(
            "Sign In",
            style: TextStyle(
                color: GlobalVariables.primaryColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
