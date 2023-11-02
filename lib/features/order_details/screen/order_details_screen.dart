import 'package:e_commerce_app/features/admin/services/admin_services.dart';
import 'package:e_commerce_app/features/auth/widgets/custom_button.dart';
import 'package:e_commerce_app/models/order.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final AdminServices adminServices = AdminServices();
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  // only admin feature
  void changeOrderStatus() {
    adminServices.changeOrderStatus(
        context: context,
        status: currentStep + 1,
        order: widget.order,
        onSuccess: () {
          setState(() {
            currentStep += 1;
          });
        });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
      ),
      body: Column(
        children: [
          Text(widget.order.id),
          Text(widget.order.address),
          for (int i = 0; i < widget.order.products.length; i++)
            Text(widget.order.products[i].name),
          Text(widget.order.id),
          Stepper(
            currentStep: currentStep,
            controlsBuilder: (context, details) {
              if (user.type == 'admin') {
                return CustomButton(label: "Done", onTap: () => changeOrderStatus());
              }
              return const SizedBox.shrink();
            },
            steps: [
              Step(
                  title: const Text('Pending'),
                  content: const Text(
                    'Your order is yet to be delivered',
                  ),
                  isActive: currentStep >= 0),
              Step(
                  title: const Text('Completed'),
                  content: const Text(
                    'Your order has been delivered, you are yet to sign.',
                  ),
                  isActive: currentStep > 1),
              Step(
                  title: const Text('Received'),
                  content: const Text(
                    'Your order has been delivered and signed by you.',
                  ),
                  isActive: currentStep > 2),
              Step(
                  title: const Text('Delivered'),
                  content: const Text(
                    'Your order has been delivered and signed by you!',
                  ),
                  isActive: currentStep >= 3),
            ],
          )
        ],
      ),
    );
  }
}
