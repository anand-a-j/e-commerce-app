import 'package:e_commerce_app/features/product_details/screens/product_details_screen.dart';
import 'package:e_commerce_app/features/search/service/search_services.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/widgets/loader.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ProductModel>? productList;
  SearchServices searchServices = SearchServices();

  @override
  void initState() {
    fetchSearchedProducts();
    super.initState();
  }

  void fetchSearchedProducts() async {
    productList = await searchServices.fetchSearchProducts(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return productList == null
        ? Loader()
        : productList!.isEmpty
            ? Text("No Products Founded")
            : Scaffold(
                body: ListView.builder(
                    itemCount: productList!.length,
                    itemBuilder: (context, index) {
                      ProductModel product = productList![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, ProductDetailsScreen.routeName,arguments: product);
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(product.images[0]),
                          ),
                          title: Text(product.name),
                          subtitle: Text(product.price.toString()),
                        ),
                      );
                    }),
              );
  }
}
