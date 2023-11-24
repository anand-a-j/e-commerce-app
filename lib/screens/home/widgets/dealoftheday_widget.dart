import 'package:e_commerce_app/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dealofday_container.dart';

class DealOfTheDayWidget extends StatelessWidget {
  const DealOfTheDayWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return homeProvider.isLoading
          ? const DealOfTheDayContainerShimmer()
          : DealOfTheDayContainer(
              product: homeProvider.dealOfTheDay[0],
            );
    });
  }
}
