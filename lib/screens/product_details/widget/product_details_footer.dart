import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/screens/cart/screen/cart_screen.dart';
import 'package:e_commerce_app/services/product_details_services.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';

class ProductDetailsFooter extends StatelessWidget {
  final ProductModel product;
  const ProductDetailsFooter({
    super.key, required this.product,
  });

  @override
  Widget build(BuildContext context) {

     ProductDetailsServices productDetailsServices = ProductDetailsServices();

      void addToCart() {
      productDetailsServices.addToCart(
        context: context,
        product: product,
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            onTap: addToCart,
            child: Container(
              height: 50,
              width: 300,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      width: 1, color: GlobalVariables.primaryColor)),
              child: const Center(
                child: Text(
                  "Add to Cart",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: GlobalVariables.primaryColor),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              addToCart();
              Navigator.pushNamed(context, CartScreen.routeName);
            },
            child: Container(
              height: 50,
              width: 300,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: GlobalVariables.primaryColor),
              child: const Center(
                child: Text(
                  "Buy Now",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
