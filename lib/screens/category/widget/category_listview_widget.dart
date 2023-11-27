import 'package:e_commerce_app/screens/category/screen/category_deals_screen.dart';
import 'package:e_commerce_app/screens/search/screens/search_screen.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';

class CategoryListViewWidget extends StatelessWidget {
  const CategoryListViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      shrinkWrap: true,
      itemCount: GlobalVariables.productCategory.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, CategoryDealsScreen.routeName,
                arguments:
                    GlobalVariables.productCategory[index]['title'].toString());
          },
          child: Container(
            height: 100,
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: GlobalVariables.backgroundColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
                BoxShadow(
                  blurRadius: 1,
                  color: Colors.grey.shade400,
                  offset: const Offset(-1, 0),
                ),
                BoxShadow(
                  blurRadius: 2,
                  color: Colors.grey.shade400,
                  offset: const Offset(1, 0),
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  margin: const EdgeInsets.only(right: 30),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            GlobalVariables.productCategory[index]['image']!),
                        fit: BoxFit.contain),
                  ),
                ),
                Text(
                  GlobalVariables.productCategory[index]['title']!,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        );
      },
    ));
  }
}

