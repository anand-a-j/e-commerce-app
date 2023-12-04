import 'package:e_commerce_app/providers/order_provider.dart';
import 'package:e_commerce_app/screens/order_details/widget/listview_order_card.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:e_commerce_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const String routeName = '/order-list-screen';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderProvider>(context, listen: false).fetchOrder(context);
    });

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
      body: Consumer<OrderProvider>(builder: (context, orderProvider, _) {
        return orderProvider.isLoading
            ? const Loader()
            : orderProvider.orders.isEmpty
                ? const Center(child: Text("No orders placed"))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: orderProvider.orders.length,
                    itemBuilder: (context, index) => ListViewOrderCard(index: index, orderProvider: orderProvider),
                    reverse: true,
                  );
      }),
    );
  }
}

