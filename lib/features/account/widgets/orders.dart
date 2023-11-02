import 'package:e_commerce_app/features/account/service/account_service.dart';
import 'package:e_commerce_app/features/account/widgets/single_product.dart';
import 'package:e_commerce_app/features/order_details/screen/order_details_screen.dart';
import 'package:e_commerce_app/models/order.dart';
import 'package:e_commerce_app/widgets/loader.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  AccountService accountService = AccountService();

  @override
  void initState() {
    fetchOrder();
    super.initState();
  }

  void fetchOrder() async {
    orders = await accountService.fetchOrderDetails(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : orders!.isEmpty
            ? const Text("No orders placed")
            : Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: const Text("Your Orders"),
                      trailing: TextButton(
                          onPressed: () {}, child: const Text("See all")),
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: orders!.length,
                          itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, OrderDetailsScreen.routeName,
                                      arguments: orders![index]);
                                },
                                child: SingleProduct(
                                  imageUrl:
                                      orders![index].products[0].images[0],
                                ),
                              )),
                    )
                  ],
                ),
              );
  }
}
