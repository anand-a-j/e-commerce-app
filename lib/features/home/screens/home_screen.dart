import 'package:e_commerce_app/features/home/widgets/product_container.dart';
import 'package:e_commerce_app/features/home/widgets/product_title.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/slider_container_widget.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    print("User ; $user");
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
                width: 0.8,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Text(" Sreach products here"),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: GlobalVariables.categoryImages.length,
                      itemBuilder: (context, index) {
                        return Chip(label: Text(GlobalVariables.categoryImages[index]['title'].toString()));
                      }),
                ),
                SliderContainerWidget(),
                productTitleWidget(),
                Container(
                  height: 170,
                  color: Colors.white,
                  child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ProductContainerWidget();
                      }),
                ),
                productTitleWidget(),
                 Container(
                  height: 170,
                  color: Colors.white,
                  child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ProductContainerWidget();
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

