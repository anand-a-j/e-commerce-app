import 'package:e_commerce_app/screens/category/screen/category_deals_screen.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';

class TopCategoryScreen extends StatelessWidget {
  const TopCategoryScreen({super.key});

  navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealsScreen.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: GridView.builder(
        itemCount: GlobalVariables.productCategory.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 30),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => navigateToCategoryPage(context,
                GlobalVariables.productCategory[index]['title'].toString()),
            child: Text(
              GlobalVariables.productCategory[index]['title'].toString(),
            ),
          );
        },
      ),
    );
  }
}
