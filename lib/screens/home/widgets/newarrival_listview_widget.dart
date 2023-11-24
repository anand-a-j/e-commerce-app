import 'package:e_commerce_app/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_container.dart';

class NewArrivalListView extends StatelessWidget {
  const NewArrivalListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return homeProvider.isLoading
          ? const ProductContainerShimmer()
          : Container(
              height: 240,
              color: Colors.white,
              child: ListView.builder(
                  reverse: true,
                  itemCount: homeProvider.newArrival.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ProductContainerWidget(
                      product: homeProvider.newArrival[index],
                    );
                  }),
            );
    });
  }
}
