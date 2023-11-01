import 'package:e_commerce_app/features/home/widgets/slider_container_widget.dart';
import 'package:e_commerce_app/features/product_details/services/product_details_services.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/widgets/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductDetailsServices productDetailsServices = ProductDetailsServices();
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void addToCart() {
    productDetailsServices.addToCart(
      context: context,
      product: widget.product,
    );
  }

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
                  RatingStars(rating: avgRating),
                  Text("₹ ${widget.product.price}"),
                  Text(widget.product.description),
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
                            rating: rating);
                      }),
                ],
              ),
            ),
          ),
          Spacer(),
          Row(
            children: [
              ElevatedButton(
                  onPressed:addToCart
                  ,
                  child: Text("Add to Cart")),
              ElevatedButton(onPressed: () {}, child: Text("Buy Now")),
            ],
          )
        ],
      ),
    );
  }
}
