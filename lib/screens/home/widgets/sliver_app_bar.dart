import 'package:e_commerce_app/models/user.dart';
import 'package:e_commerce_app/providers/location_provider.dart';
import 'package:e_commerce_app/screens/account/screen/account_screen.dart';
import 'package:e_commerce_app/screens/cart/screen/cart_screen.dart';
import 'package:e_commerce_app/screens/home/widgets/search_bar.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
         Provider.of<LocationProvider>(context, listen: false)
          .getCurrentPosition(context);
    });

    return SliverAppBar(
      expandedHeight: 110,
      backgroundColor: GlobalVariables.backgroundColor,
      title: Consumer<LocationProvider>(builder: (context, locationProvider, _) {
        print("001 hasPermission ==> ${locationProvider.hasPermission}");
        print("001 current Address ==> ${locationProvider.currentAddress}");
        return locationProvider.hasPermission != null ||
                locationProvider.hasPermission == true
            ? locationProvider.currentAddress == null
                ? const Text(
                    "Locating...",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.near_me,
                              color: GlobalVariables.primaryColor,
                            ),
                            Text(
                              locationProvider.currentAddress
                                      ?.split(',')
                                      .elementAt(1)
                                      .toString() ??
                                  "locating...",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20),
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              size: 26,
                              color: GlobalVariables.primaryColor,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          locationProvider.currentAddress ?? "Locating...",
                          style: const TextStyle(
                              color: Color(0xff545454), fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
            : const Text(
                "IShopTech",
                style: TextStyle(
                  color: GlobalVariables.primaryColor,
                  fontSize: 22,
                ),
              );
      }),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AccountScreen.routeName);
          },
          child: const ImageIcon(
            AssetImage(
              'assets/icons/profile.png',
            ),
            color: GlobalVariables.blackColor,
            size: 30,
          ),
        ),
        const SizedBox(width: 15),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, CartScreen.routeName);
          },
          child: Stack(
            children: [
              const Center(
                child: ImageIcon(
                  AssetImage(
                    'assets/icons/cart.png',
                  ),
                  color: GlobalVariables.blackColor,
                  size: 30,
                ),
              ),
              Positioned(
                top: 4,
                right: -1,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 10,
                  child: Center(
                    child: Text(
                      user.cart == null ? '0' : user.cart!.length.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 15)
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: HomeSearchBar(),
      ),
    );
  }
}
