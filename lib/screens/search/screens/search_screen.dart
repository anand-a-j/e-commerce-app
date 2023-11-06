import 'package:e_commerce_app/screens/category/widget/empty_product.dart';
import 'package:e_commerce_app/screens/product_details/screens/product_details_screen.dart';
import 'package:e_commerce_app/services/search_services.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:e_commerce_app/widgets/loader.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<ProductModel>? productList;
  SearchServices searchServices = SearchServices();

  @override
  void initState() {
    productList = [];
    super.initState();
  }

  void fetchSearchedProducts() async {
    productList = await searchServices.fetchSearchProducts(
        context: context, searchQuery: _searchController.text);
    setState(() {});
  }

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
        title: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(left: 10),
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: GlobalVariables.backgroundColor,
              border: Border.all(
                  color: const Color.fromARGB(255, 122, 122, 122), width: 0.8),
              borderRadius: Dimensions.kRadius10),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.search),
              hintText: "Search products here",
              border: InputBorder.none,
            ),
            onSubmitted: (value) {
              if (_searchController.text.isNotEmpty) {
                fetchSearchedProducts();
              } else {
                showSnackBar(context, "Enter your desired item name",isError: false);
              }
            },
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : productList!.isEmpty
              ? const EmptyProduct()
              : ListView.builder(
                  itemCount: productList!.length,
                  itemBuilder: (context, index) {
                    ProductModel product = productList![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, ProductDetailsScreen.routeName,
                            arguments: product);
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
