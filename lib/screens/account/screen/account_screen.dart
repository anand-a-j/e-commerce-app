import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/screens/cart/screen/cart_screen.dart';
import 'package:e_commerce_app/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:e_commerce_app/services/account_service.dart';
import 'package:e_commerce_app/screens/order_details/screen/orders_screen.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  static const String routeName = '/account-screen';
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.primaryColor,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: GlobalVariables.backgroundColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            },
            icon: const Icon(Icons.shopping_cart_checkout_rounded,color: Colors.white,),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
             gradient: GlobalVariables.gradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 const CircleAvatar(
                    radius: 60,
                    backgroundColor: GlobalVariables.primaryLightColor,
                    backgroundImage: AssetImage('assets/icons/profilepic.png',),
                    
                  ),
                  Dimensions.kHeight10,
                   Text(
                    user.name,
                    style: const TextStyle(
                      color: GlobalVariables.backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                MenuButton(
                    label: "My Orders",
                    icon: Icons.wallet_giftcard,
                    onPressed: () {
                      Navigator.pushNamed(context, OrdersScreen.routeName);
                    }),
                MenuButton(
                    label: "Privacy Policy",
                    icon: Icons.policy,
                    onPressed: () {
                      Navigator.pushNamed(context, PrivacyPolicyScreen.routeName);
                    }),
                MenuButton(
                    label: "Logout",
                    icon: Icons.logout,
                    onPressed: () {
                      AccountService().logOut(context);
                    }),
              ],
            ),
          ),
          // TopButtons(),
          // Orders(),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  const MenuButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onPressed,
        child: ListTile(
          leading: Icon(icon),
          title: Text(label),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
        ),
      ),
    );
  }
}
