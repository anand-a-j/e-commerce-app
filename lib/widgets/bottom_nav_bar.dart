import 'package:e_commerce_app/features/account/screen/account_screen.dart';
import 'package:e_commerce_app/features/cart/screen/cart_screen.dart';
import 'package:e_commerce_app/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> selectedIndex = ValueNotifier(0);
    List<Widget> _pages = const [HomeScreen(), CartScreen(), AccountScreen()];
    return Scaffold(
      // body: Center(child: Text("hello world"),),
      body: ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (context, updatedIndex, _) {
          return _pages[updatedIndex];
        },
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
