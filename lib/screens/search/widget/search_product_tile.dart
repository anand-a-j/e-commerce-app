import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/screens/product_details/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class SearchedProduct extends StatelessWidget {
  const SearchedProduct({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsScreen.routeName,
            arguments: product);
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(product.images[0]),
        ),
        title: Text(product.name),
        subtitle: Text(product.price.toString()),
      ),
    );
  }
}
