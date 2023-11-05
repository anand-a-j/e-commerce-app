import 'package:flutter/material.dart';

class SliderContainerWidget extends StatelessWidget {
  final String imageUrl;
  const SliderContainerWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.23,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage(
            imageUrl,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
