
import 'package:e_commerce_app/screens/cart/screen/cart_screen.dart';
import 'package:e_commerce_app/screens/product_details/widget/product_image_slider.dart';
import 'package:e_commerce_app/services/product_details_services.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
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
  void deactivate() {
    avgRating = 0;
    myRating = 0;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.backgroundColor,
        title: const Text(
          "Product Details",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: AppBarButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icons.arrow_back_ios_new_outlined,
        ),
        actions: [
          AppBarButton(
            icon: Icons.shopping_cart,
            onPressed: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                child: ListView(
                  children: [
                    ProductImageSlider(widget: widget),
                    Dimensions.kHeight20,
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Dimensions.kHeight10,
                    Text(
                      "₹ ${widget.product.price}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Dimensions.kHeight10,
                    RatingStars(rating: avgRating),
                    Dimensions.kHeight10,
                    Text(
                      widget.product.description,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                   const SizedBox(height: 10),
                    Column(
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
                                  context: context,
                                  product: widget.product,
                                  rating: rating);
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
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
          )
        ],
      ),
    );
  }
}

