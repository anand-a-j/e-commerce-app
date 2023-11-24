import 'package:e_commerce_app/screens/product_details/screens/product_details_screen.dart';
import 'package:e_commerce_app/services/product_details_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateThisProductWidget extends StatelessWidget {
  const RateThisProductWidget({
    super.key,
    required this.productDetailsServices,
    required this.widget,
  });

  final ProductDetailsServices productDetailsServices;
  final ProductDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Rate this product"),
        RatingBar.builder(
            itemCount: 5,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemBuilder: (_, context) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
            onRatingUpdate: (rating) {
              productDetailsServices.rateProducts(
                  context: context, product: widget.product, rating: rating);
            }),
      ],
    );
  }
}
