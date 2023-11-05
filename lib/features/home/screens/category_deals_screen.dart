import 'package:e_commerce_app/features/home/services/home_services.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:e_commerce_app/widgets/loader.dart';
import 'package:e_commerce_app/widgets/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
      body: productList == null
          ? Loader()
          : productList!.isEmpty
              ? const Center(
                  child: Text("No Products Available"),
                )
              : GridView.builder(
                  itemCount: productList!.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      ),
                  itemBuilder: (context, index) {
                    final product = productList![index];
                    return Container(
                      margin: const EdgeInsets.all(10),
                     
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.7, color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5)),
                              image: DecorationImage(
                                  image: NetworkImage(product.images[0]),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(product.name,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child:
                                        Text('₹ ${product.price.toString()}'),
                                  ),
                                ],
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(10.0),
                              //   child: OutlinedButton(onPressed: (){}, child:const Icon(Icons.add,color: GlobalVariables.primaryColor,)),
                              // )
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
    );
  }
}
