import 'package:e_commerce_app/screens/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../widgets/custom_button.dart';

class OrderSuccessScreen extends StatelessWidget {
  static const String routeName = '/order-success';
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              child: Lottie.asset('assets/lottie/paymentsuccess.json',
                  animate: true, 
                  fit: BoxFit.fill),
            ),
           const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Order Placed Successfully",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomButton(
                    title: "Batck To Home",
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, HomeScreen.routeName);
                    },),),
          ],
        ),
      ),
    );
  }
}
