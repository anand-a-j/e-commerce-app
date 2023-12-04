import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/screens/sign_up/widgets/sign_up_bottom_title.dart';
import 'package:e_commerce_app/screens/sign_up/widgets/sign_up_title.dart';
import 'package:e_commerce_app/services/auth_service.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _signUpFormKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SignUpTitle(),
                Dimensions.kHeight10,
                CustomTextField(
                  controller: _nameController,
                  hintText: "Username",
                  inputType: TextInputType.name,
                ),
                Dimensions.kHeight10,
                CustomTextField(
                  controller: _emailController,
                  hintText: "Email",
                  inputType: TextInputType.emailAddress,
                ),
                Dimensions.kHeight10,
                CustomTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  isPass: true,
                ),
                Dimensions.kHeight20,
                Consumer<AuthProvider>(builder: (context, authProvider, child) {
                  return CustomButton(
                      title: "SignUp",
                      isLoading: authProvider.isLoading,
                      onPressed: () {
                        if (_signUpFormKey.currentState!.validate()) {
                          authProvider.signUpUser(
                              context: context,
                              username: _nameController.text.trim(),
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim());
                        }
                      });
                }),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
                const SignUpBottomTitle()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
