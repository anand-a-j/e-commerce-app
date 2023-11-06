import 'package:e_commerce_app/services/auth_service.dart';
import 'package:e_commerce_app/screens/auth/widgets/sign_in_bottom_title.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/sign-up-screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signUpFormKey = GlobalKey<FormState>();

  AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  void signUpUser() {
    authService.signUpUser(
        context: context,
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        name: _nameController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _signUpFormKey,
          child: Column(
            children: [
              CustomTextField(
                  controller: _nameController, hintText: "Username"),
              CustomTextField(controller: _emailController, hintText: "Email"),
              CustomTextField(
                  controller: _passwordController, hintText: "Password"),
              CustomButton(title: "SignUp", onPressed: signUpUser),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
              const SignInBottomTitle()
            ],
          ),
        ),
      ),
    );
  }
}
