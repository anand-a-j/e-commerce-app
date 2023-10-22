import 'package:e_commerce_app/features/account/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         ListTile(
          title:const Text("Your Orders"),
          trailing: TextButton(onPressed: (){}, child:const Text("See all")),
         ),
         Expanded(
           child: ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context,index)=>SingleProduct()
            ),
         )
        ],
      ),
    );
  }
}