import 'package:e_commerce_app/features/home/services/home_services.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/widgets/loader.dart';
import 'package:flutter/material.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({super.key, required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  HomeServices homeServices = HomeServices();
  List<ProductModel>? productList;

  @override
  void initState() {
    fetchCategoryProducts();
    super.initState();
  }

  void fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: SizedBox(
        height: 170,
        child: productList == null
            ? Loader()
            : productList!.isEmpty
                ? const Center(
                    child: Text("No Products Available"),
                  )
                : GridView.builder(
                    itemCount: productList!.length,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1),
                    itemBuilder: (context, index) {
                      final product = productList![index];
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.7, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                                image: DecorationImage(
                                    image: NetworkImage(product.images[0]),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(product.name),
                            Text(product.price.toString()),
                          ],
                        ),
                      );
                    }),
      ),
    );
  }
}
