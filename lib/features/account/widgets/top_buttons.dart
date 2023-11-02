import 'package:e_commerce_app/features/account/service/account_service.dart';
import 'package:e_commerce_app/features/admin/screen/admin_screen.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminScreen()));
                    },
                    child: const Text("Your Orders")),
                OutlinedButton(
                    onPressed: () {}, child: const Text("Turn Sellers"))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                    onPressed: () {
                      AccountService().logOut(context);
                    },
                    child: const Text("Log Out")),
                OutlinedButton(
                    onPressed: () {}, child: const Text("Your wishlist"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
