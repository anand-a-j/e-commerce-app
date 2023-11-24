import 'package:e_commerce_app/screens/cart/widget/cart_footer.dart';
import 'package:e_commerce_app/screens/cart/widget/cart_product_widget.dart';
import 'package:e_commerce_app/screens/cart/widget/empty_cart.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:e_commerce_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart-screen';
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
 


  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    if (user.cart != null) {
      user.cart
          ?.map((e) => sum += e['quantity'] * e['product']['price'] as int)
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.backgroundColor,
        title: const Text(
          "My Cart",
          style: TextStyle(color: GlobalVariables.blackColor),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("${user.cart!.length} item",
                  style: const TextStyle(color: GlobalVariables.blackColor)),
            ),
          ),
        ],
      ),
      body: user.cart == null
          ? const Loader()
          : user.cart!.isEmpty
              ? const EmptyCart()
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: user.cart!.length,
                          itemBuilder: (context, index) {
                            final cartProduct = user.cart?[index];
                            final product =
                                ProductModel.fromMap(cartProduct['product']);
                            final quantity = cartProduct['quantity'];
                            return CartProductContainer(product: product,quantity: quantity,);
                          }),
                    ),
                    CartFooter(sum: sum)
                  ],
                ),
    );
  }
}


