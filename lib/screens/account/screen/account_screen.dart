import 'package:e_commerce_app/services/account_service.dart';
import 'package:e_commerce_app/screens/order_details/screen/orders_screen.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.backgroundColor,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: GlobalVariables.blackColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
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
                image: DecorationImage(
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1531297484001-80022131f5a1?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dGVjaHxlbnwwfHwwfHx8MA%3D%3D"),
                    fit: BoxFit.cover)),
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
                    onPressed: () {}),
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
