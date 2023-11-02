import 'package:e_commerce_app/features/admin/screen/analytics_screen.dart';
import 'package:e_commerce_app/features/admin/screen/orders_screen.dart';
import 'package:e_commerce_app/features/admin/screen/posts_screen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> selectedIndex = ValueNotifier(0);
     List<Widget> _pages = const [
     PostsScreen(),
      AnalyticsScreen(),
     OrderScreen()
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("E Commerce"),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.admin_panel_settings)
          )
        ],
      ),
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
                      icon: Icon(Icons.list), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.analytics), label: "Analytics"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_box), label: "Orders")
                ]);
          }),
      

      
    );
  }
}