import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height*0.05,
      decoration:const BoxDecoration(
        gradient: GlobalVariables.appBarGradient
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text("Hello, Admin",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),

      ),
    );
  }
}