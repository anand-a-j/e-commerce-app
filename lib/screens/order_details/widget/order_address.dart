import 'package:e_commerce_app/models/order.dart';
import 'package:flutter/material.dart';

class OrderAddressSection extends StatelessWidget {
  const OrderAddressSection({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 150,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.7, color: const Color(0xffcccccc))),
        child: Text(
          order.address,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
