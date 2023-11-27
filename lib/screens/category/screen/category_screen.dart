import 'package:e_commerce_app/screens/search/screens/search_screen.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.backgroundColor,
        title: const Text(
          "Category",
          style: TextStyle(color: GlobalVariables.blackColor),
        ),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          SearchBar(),
          CategoryListViewWidget()
        ],
      ),
    );
  }
}

class CategoryListViewWidget extends StatelessWidget {
  const CategoryListViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      shrinkWrap: true,
      itemCount: GlobalVariables.productCategory.length,
      itemBuilder: (context, index) {
        return Container(
          height: 100,
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: GlobalVariables.backgroundColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                blurRadius: 3,
                color: Colors.grey.shade400,
                offset: const Offset(-1, 0),
              ),
              BoxShadow(
                blurRadius: 5,
                color: Colors.grey.shade400,
                offset: const Offset(2, 0),
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 90,
                width: 90,
                margin: const EdgeInsets.only(right: 30),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(GlobalVariables.productCategory[index]['image']!),
                    fit: BoxFit.contain
                  ),
                ),
              ),
              Text(GlobalVariables.productCategory[index]['title']!,
               style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
               ),
              )
    
            ],
          ),
        );
      },
    ));
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SearchScreen.routeName);
      },
      child: Container(
        height: 55,
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: GlobalVariables.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: const Icon(Icons.search_outlined),
          title: const Text("Search your desired products here"),
          titleTextStyle: TextStyle(color: Colors.grey.shade600),
        ),
      ),
    );
  }
}
