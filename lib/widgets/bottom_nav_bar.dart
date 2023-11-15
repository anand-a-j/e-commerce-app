import 'package:e_commerce_app/screens/account/screen/account_screen.dart';
import 'package:e_commerce_app/screens/cart/screen/cart_screen.dart';
import 'package:e_commerce_app/screens/home/screens/home_screen.dart';
import 'package:e_commerce_app/services/network_service.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      NetworkService().isDeviceOffline(context);
    });
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: const Text('Confirm Exit'),
              content: const Text('Do you want to exit the App?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }

    ValueNotifier<int> selectedIndex = ValueNotifier(0);
    List<Widget> pages = const [HomeScreen(), CartScreen(), AccountScreen()];
    return Scaffold(
      body: WillPopScope(
        onWillPop: showExitPopup,
        child: ValueListenableBuilder(
          valueListenable: selectedIndex,
          builder: (context, updatedIndex, _) {
            return pages[updatedIndex];
          },
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: selectedIndex,
          builder: (context, updatedIndex, _) {
            return BottomNavigationBar(
                currentIndex: updatedIndex,
                onTap: (index) {
                  selectedIndex.value = index;
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage(
                          'assets/icons/home.png',
                        ),
                      ),
                      label: "Home"),
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage(
                          'assets/icons/cart.png',
                        ),
                      ),
                      label: "Cart"),
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage(
                          'assets/icons/user.png',
                        ),
                      ),
                      label: "Profile"),
                ]);
          }),
    );
  }
}
