import 'package:e_commerce_app/features/home/widgets/slider_container_widget.dart';
import 'package:e_commerce_app/features/product_details/services/product_details_services.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductDetailsServices productDetailsServices = ProductDetailsServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: ListView(
                children: [
                  SliderContainerWidget(),
                  Text(widget.product.name),
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
                            context: context,
                            product: widget.product,
                            rating: rating
                            );
                      }),
                  Text("₹ ${widget.product.price}"),
                  Text(widget.product.description)
                ],
              ),
            ),
          ),
          Spacer(),
          Row(
            children: [
              ElevatedButton(onPressed: () {}, child: Text("Add to Cart")),
              ElevatedButton(onPressed: () {}, child: Text("Buy Now")),
            ],
          )
        ],
      ),
    );
  }
}
