import 'package:e_commerce_app/features/admin/services/admin_services.dart';
import 'package:e_commerce_app/features/order_details/screen/order_details_screen.dart';
import 'package:e_commerce_app/models/order.dart';
import 'package:e_commerce_app/widgets/loader.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order>? orders;
  AdminServices adminServices = AdminServices();

  @override
  void initState() {
    getAllOrders();
    super.initState();
  }

  void getAllOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? Loader()
        : orders!.isEmpty
            ? Text("No orders placed")
            : ListView.builder(
                itemCount: orders!.length,
                itemBuilder: (context, index) {
                  var order = orders![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, OrderDetailsScreen.routeName,arguments: order);
                    },
                    child: ListTile(
                      title: Text(order.orderedAt.toString()),
                    ),
                  );
                },
              );
  }
}
