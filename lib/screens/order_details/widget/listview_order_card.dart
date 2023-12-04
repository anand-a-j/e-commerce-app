import 'package:e_commerce_app/providers/order_provider.dart';
import 'package:e_commerce_app/screens/order_details/screen/order_details_screen.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';

class ListViewOrderCard extends StatelessWidget {
  final int index;
  final OrderProvider orderProvider;
  const ListViewOrderCard({
    super.key,
    required this.index,
    required this.orderProvider,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, OrderDetailsScreen.routeName,
            arguments: orderProvider.orders[index]);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(width: 0.8, color: const Color(0xffcccccc)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Order ID:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  orderProvider.orders[index].id,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Date:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  dateConvert(orderProvider.orders[index].orderedAt),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Price:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '₹ ${orderProvider.orders[index].totalPrice.toString()}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Status",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                orderStatus(orderProvider.orders[index].status)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
