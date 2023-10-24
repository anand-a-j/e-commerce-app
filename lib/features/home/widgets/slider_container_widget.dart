import 'package:flutter/material.dart';

class SliderContainerWidget extends StatelessWidget {
  const SliderContainerWidget({
    super.key,
  });

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
                  "https://images.unsplash.com/photo-1609081219090-a6d81d3085bf?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGdhZGdldHxlbnwwfDB8MHx8fDA%3D"),
              fit: BoxFit.cover)),
    );
  }
}
