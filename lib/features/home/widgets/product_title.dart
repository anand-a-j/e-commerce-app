import 'package:flutter/material.dart';

class productTitleWidget extends StatelessWidget {
  const productTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Deal of the Day",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          TextButton(onPressed: () {}, child: Text("View All")),
        ],
      ),
    );
  }
}
