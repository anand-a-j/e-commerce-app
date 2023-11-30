import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/services/cart_services.dart';
import 'package:e_commerce_app/services/product_details_services.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';

class CartProductContainer extends StatelessWidget {
  final ProductModel product;
  final dynamic quantity;
  const CartProductContainer({
    super.key,
    required this.product,
    this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final CartServices cartServices = CartServices();
    final ProductDetailsServices productDetailsServices =
        ProductDetailsServices();

    void increaseQuantity(ProductModel product) {
      productDetailsServices.addToCart(context: context, product: product);
    }

    void decreaseQuantity(ProductModel product) {
      cartServices.removeFromCart(context: context, product: product);
    }

    return Container(
      height: 130,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: Color(0xffcccccc),
          spreadRadius: 1,
          blurRadius: 6,
          offset: Offset(0, 6),
        ),
        BoxShadow(
          blurRadius: 3,
          color: Color(0xffcccccc),
          offset: Offset(-1, 0),
        ),
        BoxShadow(
          blurRadius: 5,
          color: Color(0xffcccccc),
          offset: Offset(2, 0),
        )
      ], borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Row(
        children: [
          Container(
            height: 130,
            width: 130,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(
                  product.images[0],
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                  left: 10, top: 15, bottom: 5, right: 10),
              height: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Free Delivery",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "₹ ${product.price}",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                            color: GlobalVariables.primaryColor,
                            borderRadius: BorderRadius.circular(5),
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
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(quantity.toString()),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          increaseQuantity(product);
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            color: GlobalVariables.primaryColor,
                            borderRadius: BorderRadius.circular(5),
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
  }
}
