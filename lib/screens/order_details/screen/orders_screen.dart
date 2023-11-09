import 'package:e_commerce_app/services/account_service.dart';
import 'package:e_commerce_app/screens/account/widgets/single_product.dart';
import 'package:e_commerce_app/screens/order_details/screen/order_details_screen.dart';
import 'package:e_commerce_app/models/order.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:e_commerce_app/widgets/loader.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName = '/order-list-screen';
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.backgroundColor,
        title: const Text(
          "My Orders",
          style: TextStyle(
            color: GlobalVariables.blackColor,
          ),
        ),
      ),
      body: orders == null
          ? const Loader()
          : orders!.isEmpty
              ? const Text("No orders placed")
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: orders!.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, OrderDetailsScreen.routeName,
                          arguments: orders![index]);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.8,
                          color: Colors.grey
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order ID:",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                orders![index].id,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text(
                                "Items:",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                orders![index].products.length.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Price:",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '₹ ${orders![index].totalPrice.toString()}',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Date:",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                DateTime.fromMillisecondsSinceEpoch(
                                        orders![index].orderedAt)
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}
