import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/screens/auth/widgets/login_title.dart';
import 'package:e_commerce_app/screens/auth/widgets/sign_in_bottom_title.dart';
import 'package:e_commerce_app/services/network_service.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/sign-in-screen';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      NetworkService().isDeviceOffline(context);
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _signInFormKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LoginTitle(),
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
                      isLoading: authProvider.isLoading,
                      title: "Login",
                      onPressed: () {
                        if (_emailController.text.isEmpty ||
                            _passwordController.text.isEmpty) {
                          showSnackBar(context, "Enter all the fields");
                        } else {
                          if (_signInFormKey.currentState!.validate()) {
                            authProvider.signInUser(
                                context,
                                _emailController.text.trim(),
                                _passwordController.text.trim());
                          }
                        }
                      });
                }),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
                const SignInBottomTitle()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
