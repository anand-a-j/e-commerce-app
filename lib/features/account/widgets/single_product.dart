import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String imageUrl;
  const SingleProduct({super.key, required this.imageUrl,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.15,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  imageUrl)),
          border: Border.all(color: Colors.black.withOpacity(0.8)),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
