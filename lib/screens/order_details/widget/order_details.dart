import 'package:e_commerce_app/models/order.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';

class OrderDetailsSection extends StatelessWidget {
  const OrderDetailsSection({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const Text("Order Id"), Text(order.id)],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const Text("Date"), Text(dateConvert(order.orderedAt))],
          ),
        ),
      ],
    );
  }
}
