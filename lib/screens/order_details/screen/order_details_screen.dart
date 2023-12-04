import 'package:e_commerce_app/screens/home/widgets/product_title.dart';
import 'package:e_commerce_app/models/order.dart';
import 'package:e_commerce_app/screens/order_details/widget/order_address.dart';
import 'package:e_commerce_app/screens/order_details/widget/order_details.dart';
import 'package:e_commerce_app/screens/order_details/widget/order_price_details.dart';
import 'package:e_commerce_app/screens/order_details/widget/order_product.dart';
import 'package:e_commerce_app/screens/order_details/widget/order_stepper.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.backgroundColor,
        title: const Text(
          "Order Details",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const ProductTitleWidget(label: "Order Details"),
          OrderDetailsSection(order: order),
          const ProductTitleWidget(label: "Shipping Address"),
          OrderAddressSection(order: order),
          const ProductTitleWidget(label: "Products"),
          OrderProductsSection(order: order),
          const ProductTitleWidget(label: "Price Details"),
          OrderPriceDetailsSection(order: order),
          const SizedBox(height: 5),
          const ProductTitleWidget(label: "Order Status"),
          OrderStepperSection(order: order)
        ],
      ),
    );
  }
}
