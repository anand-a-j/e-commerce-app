import 'package:e_commerce_app/screens/product_details/screens/product_details_screen.dart';
import 'package:e_commerce_app/services/product_details_services.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductContainerWidget extends StatelessWidget {
  final ProductModel product;
  const ProductContainerWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final ProductDetailsServices productDetailsServices =
        ProductDetailsServices();

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsScreen.routeName,
            arguments: product);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 165,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
            BoxShadow(
              blurRadius: 3,
              color: Colors.grey,
              offset: Offset(-1, 0),
            ),
            BoxShadow(
              blurRadius: 4,
              color: Colors.grey,
              offset: Offset(1, 0),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: 165,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                image: DecorationImage(
                  image: NetworkImage(product.images[0]),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text("₹ ${product.price}"),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                productDetailsServices.addToCart(
                    context: context, product: product);
                showSnackBar(context, "Product Added to Cart", isError: false);
              },
              child: Container(
                height: 35,
                width: double.infinity,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: GlobalVariables.primaryColor),
                child: const Center(
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductContainerShimmer extends StatelessWidget {
  const ProductContainerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: SizedBox(
        height: 240,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(10),
              height: 120,
              width: 165,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.grey),
            );
          },
        ),
      ),
    );
  }
}
