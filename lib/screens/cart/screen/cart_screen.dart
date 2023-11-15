import 'package:e_commerce_app/screens/address/screen/address_screen.dart';
import 'package:e_commerce_app/screens/cart/widget/empty_cart.dart';
import 'package:e_commerce_app/services/cart_services.dart';
import 'package:e_commerce_app/services/product_details_services.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
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

                            return Container(
                              height: 130,
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 1,
                                      blurRadius: 6,
                                      offset: Offset(0, 6),
                                    ),
                                    BoxShadow(
                                      blurRadius: 3,
                                      color: Colors.grey,
                                      offset: Offset(-1, 0),
                                    ),
                                    BoxShadow(
                                      blurRadius: 5,
                                      color: Colors.grey,
                                      offset: Offset(2, 0),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              child: Row(
                                children: [
                                  Container(
                                    height: 130,
                                    width: 130,
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: NetworkImage(product.images[0]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 10,
                                          top: 15,
                                          bottom: 5,
                                          right: 10),
                                      height: 130,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(product.name,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "Free Delivery",
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "₹ ${product.price}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  decreaseQuantity(product);
                                                },
                                                child: Container(
                                                  //  margin: EdgeInsets.all(5),
                                                  height: 25,
                                                  width: 25,
                                                  decoration: BoxDecoration(
                                                    color: GlobalVariables
                                                        .primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                //  margin: EdgeInsets.all(5),
                                                height: 25,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                        quantity.toString())),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  increaseQuantity(product);
                                                },
                                                child: Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration: BoxDecoration(
                                                    color: GlobalVariables
                                                        .primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 5),
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
                        CustomButton(
                          title: "CheckOut",
                          onPressed: () {
                            final user = context.read<UserProvider>().user;
                            for (int i = 0; i < user.cart!.length; i++) {
                              if (user.cart![i]['product']['quantity'] < 1) {
                                showSnackBar(context,
                                    '${user.cart![i]['product']['name']} is out of stock');
                                return;
                              }
                            }
                            Navigator.pushNamed(
                                context, AddressScreen.routeName,
                                arguments: sum.toDouble());
                          },
                        )
                      ],
                    )
                  ],
                ),
    );
  }
}
