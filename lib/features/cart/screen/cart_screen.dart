import 'package:e_commerce_app/features/cart/services/cart_services.dart';
import 'package:e_commerce_app/features/product_details/services/product_details_services.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  final CartServices cartServices = CartServices();

  void increaseQuantity(ProductModel product) {
    productDetailsServices.addToCart(context: context, product: product);
  }

  void decreaseQuantity(ProductModel product) {
    cartServices.removeFromCart(context: context, product: product);
  }

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
          title: const Text("Cart"),
        ),
        body: user.cart == null
            ? Center(
                child: Text("No items in the cart"),
              )
            : Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Total"), Text(sum.toString())],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: user.cart!.length,
                        itemBuilder: (context, index) {
                          final cartProduct = user.cart?[index];
                          final product =
                              ProductModel.fromMap(cartProduct['product']);
                          final quantity = cartProduct['quantity'];
                          return ListTile(
                              title: Text(product.name),
                              subtitle: Text(product.price.toString()),
                              trailing: Wrap(
                                alignment: WrapAlignment.spaceAround,
                                direction: Axis.horizontal,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        increaseQuantity(product);
                                        print(
                                            "Product add more pro => $product");
                                      },
                                      icon: Icon(Icons.add)),
                                  Text(quantity.toString()),
                                  IconButton(
                                      onPressed: () {
                                        decreaseQuantity(product);
                                      },
                                      icon: Icon(Icons.minimize)),
                                ],
                              ));
                        }),
                  ),
                ],
              ));
  }
}
