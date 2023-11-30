import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/providers/category_provider.dart';
import 'package:e_commerce_app/screens/product_details/screens/product_details_screen.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:e_commerce_app/widgets/rating_stars.dart';
import 'package:flutter/material.dart';

class CategoryProductsWidget extends StatelessWidget {
  const CategoryProductsWidget(
      {super.key, required this.product, required this.category});

  final ProductModel product;
  final CategoryProvider category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsScreen.routeName,
            arguments: product);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: GlobalVariables.backgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
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
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                color: GlobalVariables.backgroundColor,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(product.images[0]),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Dimensions.kWidth20,
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Dimensions.kHeight10,
                  RatingStars(
                      rating: category.calculateAvgRating(product.rating)),
                  Dimensions.kHeight10,
                  Text(
                    '₹ ${product.price.toString()}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
