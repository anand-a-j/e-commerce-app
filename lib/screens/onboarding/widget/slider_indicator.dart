import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final bool isActive;

  const Indicator({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      width: isActive ? 20.0 : 10.0,
      height: isActive ? 10.0 : 5.0,
      decoration: BoxDecoration(
        color: isActive ? GlobalVariables.primaryColor : Colors.grey,
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
    );
  }
}
