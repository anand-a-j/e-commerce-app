import 'package:e_commerce_app/features/account/widgets/orders.dart';
import 'package:e_commerce_app/features/account/widgets/top_buttons.dart';
import 'package:e_commerce_app/features/account/widgets/below_appbar.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient
            ),
          ),
          title: Text("E Commerce App"),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
            IconButton(onPressed: (){}, icon: Icon(Icons.search))
          ],
        ), 
      preferredSize:const Size.fromHeight(50)
      ),
      body: Column(
        children: [
          BelowAppBar(),
          TopButtons(),
          Orders()
        ],
      ),
    );
  }
}