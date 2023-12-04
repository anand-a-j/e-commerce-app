import 'package:e_commerce_app/models/order.dart';
import 'package:flutter/material.dart';

class OrderProductsSection extends StatelessWidget {
  const OrderProductsSection({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                    image: NetworkImage(product.images[0]), fit: BoxFit.cover),
              ),
            ),
            title: Text(product.name),
            subtitle:
                Text("Quantity: ${product.quantity} Price: ${product.price}"),
          ),
        );
      },
    );
  }
}
