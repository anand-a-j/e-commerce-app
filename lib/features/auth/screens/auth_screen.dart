import 'package:e_commerce_app/features/auth/services/auth_service.dart';
import 'package:e_commerce_app/features/auth/widgets/custom_button.dart';
import 'package:e_commerce_app/features/auth/widgets/custom_textfield.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  void signUpUser() {
    authService.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text);
  }

  void signInUser() {
    print("sign in user function called");
    
    authService.signInUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                "Welcome",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              ListTile(
                title: const Text("Create Account"),
                leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signup,
                    groupValue: _auth,
                    onChanged: (value) {
                      setState(() {
                        _auth = value!;
                      });
                    }),
              ),
              if (_auth == Auth.signup)
                Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                          controller: _emailController, hintText: "Email"),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      CustomTextField(
                          controller: _passwordController,
                          hintText: "Password"),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      CustomTextField(
                          controller: _nameController, hintText: "Username"),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      CustomButton(
                          label: "Sign Up",
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signUpUser();
                            }
                          })
                    ],
                  ),
                ),
              ListTile(
                title: const Text("Log In Here"),
                leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: (value) {
                      setState(() {
                        _auth = value!;
                      });
                    }),
              ),
              if (_auth == Auth.signin)
                Form(
                  key: _signInFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                          controller: _emailController, hintText: "Email"),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      CustomTextField(
                          controller: _passwordController,
                          hintText: "Password"),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      CustomButton(
                          label: "Sign In",
                          onTap: () {
                            if (_signInFormKey.currentState!.validate()) {
                              signInUser();
                            }
                          })
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
