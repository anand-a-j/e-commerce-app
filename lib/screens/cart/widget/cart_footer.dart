import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/screens/address/screen/address_screen.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartFooter extends StatelessWidget {
  const CartFooter({
    super.key,
    required this.sum,
  });

  final int sum;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total:",
                style: TextStyle(
                    // color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                "₹ $sum",
                style: const TextStyle(
                    // color: GlobalVariables.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CustomButton(
            title: "Checkout",
            onPressed: () {
              final user = context.read<UserProvider>().user;
              for (int i = 0; i < user.cart!.length; i++) {
                if (user.cart![i]['product']['quantity'] < 1) {
                  showSnackBar(context,
                      '${user.cart![i]['product']['name']} is out of stock');
                  return;
                }
              }
              Navigator.pushNamed(context, AddressScreen.routeName,
                  arguments: sum.toDouble());
            },
          ),
        )
      ],
    );
  }
}
