import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/screens/home/widgets/slider_container_widget.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';

class HomeBannerSlider extends StatelessWidget {
  const HomeBannerSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: GlobalVariables.carouselImages.length,
      itemBuilder: (context, index, _) {
        return SliderContainerWidget(
          imageUrl: GlobalVariables.carouselImages[index],
        );
      },
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        viewportFraction: 0.95,
      ),
    );
  }
}
