import 'package:e_commerce_app/screens/home/widgets/product_title.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:e_commerce_app/utils/strings.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static const String routeName = '/privacy-policy';
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.backgroundColor,
        title: const Text(
          "Policy",
          style: TextStyle(color: GlobalVariables.blackColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          shrinkWrap: true,
          children: const [
            ProductTitleWidget(label: "Privacy Policy"),
            SizedBox(height: 10),
            Text(privacyPolicy)
          ],
        ),
      ),
    );
  }
}
