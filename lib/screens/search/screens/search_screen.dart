import 'package:e_commerce_app/providers/search_provider.dart';
import 'package:e_commerce_app/screens/category/widget/empty_product.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/screens/search/widget/search_product_tile.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:e_commerce_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.backgroundColor,
        title: searchTextField(),
      ),
      body: Consumer<SearchProvider>(
        builder: (context,search,_) {
          return search.productList == null
              ? const Loader()
              : search.productList!.isEmpty
                  ? const EmptyProduct()
                  : ListView.builder(
                      itemCount: search.productList!.length,
                      itemBuilder: (context, index) {
                        ProductModel product = search.productList![index];
                        return SearchedProduct(product: product);
                      });
        }
      ),
    );
  }

  Container searchTextField() {
    return Container(
        // margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(left: 10),
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: GlobalVariables.backgroundColor,
            border: Border.all(
                color: const Color.fromARGB(255, 122, 122, 122), width: 0.8),
            borderRadius: Dimensions.kRadius10),
        child: Consumer<SearchProvider>(builder: (context, search, _) {
          return TextField(
            controller: _searchController,
            autofocus: true,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.search),
              hintText: "Search products here",
              border: InputBorder.none,
            ),
            onSubmitted: (value) {
              if (_searchController.text.isNotEmpty) {
                search.fetchSearchedProducts(context, _searchController.text.trim());
              } else {
                showSnackBar(context, "Enter your desired item name",
                    isError: false);
              }
            },
          );
        }),
      );
  }
}

