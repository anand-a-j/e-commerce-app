import 'package:e_commerce_app/screens/address/screen/address_screen.dart';
import 'package:e_commerce_app/services/cart_services.dart';
import 'package:e_commerce_app/services/product_details_services.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
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
            child: Text("${user.cart!.length} items",
                style: TextStyle(color: GlobalVariables.blackColor)),
          ))
          // IconButton(onPressed: (){
          //   Navigator.pushNamed(context, AddressScreen.routeName);
          // }, icon: Icon(Icons.save))
        ],
      ),
      body: user.cart == null || user.cart!.isEmpty
          ? Center(
              child: Text("No items in the cart"),
            )
          : Column(
              children: [
                // Container(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [Text("Total"), Text(sum.toString())],
                //   ),
                // ),
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
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.amber),
                          child: Row(
                            children: [
                              Container(
                                height: 130,
                                width: 130,
                                margin: EdgeInsets.all(10),
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
                                  margin: EdgeInsets.only(
                                      left: 10, top: 15, bottom: 5, right: 10),
                                  height: 130,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400)),
                                      SizedBox(height: 5,),
                                      Text("Free Delivery"),
                                      SizedBox(height: 5,),
                                      Text(
                                        "₹ ${product.price}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              increaseQuantity(product);
                                            },
                                            child: Container(
                                              //  margin: EdgeInsets.all(5),
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                color: GlobalVariables.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.add,
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
                                                child:
                                                    Text(quantity.toString())),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              decreaseQuantity(product);
                                            },
                                            child: Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                color: GlobalVariables.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.compare_arrows_sharp,
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
                      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total:",
                            style: TextStyle(
                                // color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Text(
                            "₹ $sum",
                            style: TextStyle(
                                // color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, AddressScreen.routeName,arguments:sum.toDouble());
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10),
                        decoration: BoxDecoration(
                            color: GlobalVariables.primaryColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: const Center(
                          child: Text(
                            "Checkout",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
