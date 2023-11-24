
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';

import '../screens/product_details_screen.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({
    super.key,
    required this.widget,
  });

  final ProductDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: GlobalVariables.carouselImages.length,
      itemBuilder: (context, index, _) {
        return Container(
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              image: NetworkImage(
                widget.product.images[0],
              ),
              fit: BoxFit.contain,
            ),
          ),
        );
      },
      options: CarouselOptions(
        aspectRatio: 16 / 10,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        viewportFraction: 0.95,
      ),
    );
  }
}

class AppBarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const AppBarButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: 50,
      width: 50,
      // decoration: BoxDecoration(
      //     color: GlobalVariables.primaryColor.withOpacity(0.7), borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: GlobalVariables.blackColor,
            )),
      ),
    );
  }
}
