import 'package:e_commerce_app/models/user.dart';
import 'package:e_commerce_app/screens/account/screen/account_screen.dart';
import 'package:e_commerce_app/screens/cart/screen/cart_screen.dart';
import 'package:e_commerce_app/screens/home/widgets/search_bar.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      
      expandedHeight: 110,
      backgroundColor: GlobalVariables.backgroundColor,
      title: const Text(
        "IShopTech",
        style: TextStyle(
          color: GlobalVariables.primaryColor,
          fontSize: 22,
        ),
      ),
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
                      style: const TextStyle(fontSize: 12,color: Colors.white),
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
