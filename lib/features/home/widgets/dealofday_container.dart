import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DealOfTheDayContainer extends StatelessWidget {
  final ProductModel product;
  const DealOfTheDayContainer({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Container(
          margin:const EdgeInsets.all(10),
          width: 1000,
          height: 270,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: NetworkImage(product.images[0]),
                  fit: BoxFit.cover)),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            margin:const EdgeInsets.all(10),
            height: 45,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius:const BorderRadius.only(topRight: Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DealOfTheDayContainerShimmer extends StatelessWidget {
  const DealOfTheDayContainerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 1000,
        height: 270,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.grey),
      ),
    );
  }
}
