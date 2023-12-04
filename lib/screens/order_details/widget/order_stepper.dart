import 'package:e_commerce_app/models/order.dart';
import 'package:flutter/material.dart';

class OrderStepperSection extends StatelessWidget {
  const OrderStepperSection({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: order.status,
      controlsBuilder: (context, details) {
        return const SizedBox.shrink();
      },
      steps: [
        Step(
            title: const Text('Pending'),
            content: const Text(
              'Your order is yet to be delivered',
            ),
            isActive: order.status >= 0),
        Step(
            title: const Text('Packed'),
            content: const Text(
              'Order packed and shipping soon!',
            ),
            isActive: order.status >= 1),
        Step(
            title: const Text('Shipping'),
            content: const Text(
              'Your order stated shipping',
            ),
            isActive: order.status >= 2),
        Step(
            title: const Text('Delivered'),
            content: const Text(
              'Your order has been delivered and signed by you!',
            ),
            isActive: order.status >= 3),
      ],
    );
  }
}
