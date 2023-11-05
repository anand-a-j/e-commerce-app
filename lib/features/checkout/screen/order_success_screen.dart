import 'package:e_commerce_app/features/auth/widgets/custom_button.dart';
import 'package:e_commerce_app/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

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
              height: 300,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://plus.unsplash.com/premium_photo-1689620817504-2f77cbddf142?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDF8Q0R3dXdYSkFiRXd8fGVufDB8fHx8fA%3D%3D"),
                      fit: BoxFit.contain)),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
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
                    label: "Back To Home",
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, HomeScreen.routeName);
                    })),
          ],
        ),
      ),
    );
  }
}
