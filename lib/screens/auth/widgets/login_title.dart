import 'package:flutter/material.dart';

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.20,
          ),
          const Text(
            "Hi, Welcome Back!👋",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 34, color: Colors.black),
          ),
          const Text(
            "Login with your credentials.",
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 18, color: Colors.black),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.10,
          )
        ],
      ),
    );
  }
}