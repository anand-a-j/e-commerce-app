import 'package:e_commerce_app/screens/search/screens/search_screen.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SearchScreen.routeName);
      },
      child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(left: 10),
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: GlobalVariables.backgroundColor,
              border: Border.all(
                  color: const Color.fromARGB(255, 200, 200, 200), width: 0.7),
              borderRadius: Dimensions.kRadius10,
              boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1),
              ),
              // BoxShadow(
              //   blurRadius: 2,
              //   color: Colors.grey,
              //   offset: Offset(-1, 0),
              // ),
              // BoxShadow(
              //   blurRadius: 2,
              //   color: Colors.grey,
              //   offset: Offset(1, 0),
              // )
            ],
              ),
              
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Search your products",
                  style: TextStyle(fontSize: 16),
                ),
                Icon(Icons.search)
              ],
            ),
          )),
    );
  }
}
