import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyProduct extends StatelessWidget {
  const EmptyProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: 350,
              child: Center(
                child: Lottie.asset('assets/lottie/emptyitem.json',
                    animate: true, repeat: true, fit: BoxFit.contain),
              ),
            ),
            Dimensions.kHeight10,
            const Text("No items available"),
          ],
        ),
      ),
    );
  }
}