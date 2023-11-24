import 'package:e_commerce_app/screens/category/screen/category_deals_screen.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Center(
        child: GridView.builder(
            scrollDirection: Axis.horizontal,
            physics: const PageScrollPhysics(),
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, CategoryDealsScreen.routeName,
                      arguments: GlobalVariables
                          .productCategory[index]['title']
                          .toString());
                },
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: GlobalVariables.primaryLightColor,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: Offset(0, 6),
                            ),
                            BoxShadow(
                              blurRadius: 3,
                              color: Colors.grey,
                              offset: Offset(-1, 0),
                            ),
                            BoxShadow(
                              blurRadius: 5,
                              color: Colors.grey,
                              offset: Offset(2, 0),
                            )
                          ],
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  GlobalVariables
                                    .productCategory[index]['image']
                                    .toString()
                                  ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Dimensions.kHeight10,
                      Text(
                        GlobalVariables.productCategory[index]
                                ['title']
                            .toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
