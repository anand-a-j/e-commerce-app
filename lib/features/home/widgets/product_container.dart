import 'package:flutter/material.dart';

class ProductContainerWidget extends StatelessWidget {
  const ProductContainerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            blurRadius: 3,
            color: Colors.grey,
            offset: const Offset(-1, 0),
          ),
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey,
            offset: const Offset(2, 0),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90,
            width: 120,
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1609081219090-a6d81d3085bf?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGdhZGdldHxlbnwwfDB8MHx8fDA%3D"),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "HeadPhone",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 5,
          ),
          Text("₹ 1200")
        ],
      ),
    );
  }
}
