import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const CustomButton({super.key, required this.label,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          color: GlobalVariables.secondaryColor,
          borderRadius: BorderRadius.circular(5)),
      child: ElevatedButton(onPressed: onTap, child: Text(label))
    );
  }
}
