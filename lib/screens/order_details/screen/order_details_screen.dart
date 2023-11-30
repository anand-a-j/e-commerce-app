import 'package:e_commerce_app/screens/home/widgets/product_title.dart';
import 'package:e_commerce_app/models/order.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:e_commerce_app/utils/utils.dart';
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
          Column(
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
                  children: [
                    const Text("Date"),
                    Text(dateConvert(order.orderedAt))
                  ],
                ),
              ),
            ],
          ),
          const ProductTitleWidget(label: "Shipping Address"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 150,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0.7, color: Color(0xffcccccc))),
              child: Text(
                order.address,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const ProductTitleWidget(label: "Products"),
          ListView.builder(
            shrinkWrap: true,
            itemCount: order.products.length,
            itemBuilder: (context, index) {
              var product = order.products[index];
              return SizedBox(
                height: 70,
                width: double.infinity,
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.purple.shade100,
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: NetworkImage(product.images[0]),
                          fit: BoxFit.cover),
                    ),
                  ),
                  title: Text(product.name),
                  subtitle: Text(
                      "Quantity: ${product.quantity} Price: ${product.price}"),
                ),
              );
            },
          ),
          const ProductTitleWidget(label: "Price Details"),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total"),
                    Text(order.totalPrice.toString())
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Delivery Charge"), Text("Free")],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Tax"), Text("₹0.00")],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 1,
                  color: Color(0xffcccccc),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Sub Total"),
                    Text('₹ ${order.totalPrice}0')
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const ProductTitleWidget(label: "Order Status"),
          Stepper(
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
          )
        ],
      ),
    );
  }
}
