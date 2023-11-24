import 'package:e_commerce_app/providers/onboarding_provider.dart';
import 'package:e_commerce_app/screens/auth/screens/sign_in_screen.dart';
import 'package:e_commerce_app/screens/onboarding/widget/slider_indicator.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
   final PageController controller = PageController();

    final List<String> images = [
      'assets/onboarding/1.png',
      'assets/onboarding/2.png',
      'assets/onboarding/3.png',
    ];

    return Consumer<OnboardingProvider>(
      builder: (context, onboard, _) {
        return Scaffold(
          body: Stack(
            children: [
    
             PageView.builder(
                  controller: controller,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      images[index],
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
                    );
                  },
                  onPageChanged: (index) {
                    onboard.setCurrentPage(index);
                  },
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < images.length; i++)
                        Indicator(
                          isActive: onboard.currentPage == i,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: GlobalVariables.primaryColor,
            onPressed: () async {
              if (onboard.currentPage < images.length - 1) {
                controller.nextPage(
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeInOut);
              } else {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('onboardingCompleted', true);
               if(context.mounted) {
                 Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ),
                );
               }
              }
            },
            child: Icon(onboard.currentPage < images.length - 1
                ? Icons.arrow_forward_ios
                : Icons.check,
                color: GlobalVariables.backgroundColor,
                ),
          ),
        );
      }
    );
  }
}

