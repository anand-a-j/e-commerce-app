import 'package:e_commerce_app/providers/home_provider.dart';
import 'package:e_commerce_app/screens/home/widgets/product_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BestDealListView extends StatelessWidget {
  const BestDealListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return homeProvider.isLoading
          ? const ProductContainerShimmer()
          : SizedBox(
              height: 240,
              child: ListView.builder(
                  itemCount: homeProvider.dealOfTheDay.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ProductContainerWidget(
                      product: homeProvider.dealOfTheDay[index],
                    );
                  }),
            );
    });
  }
}
