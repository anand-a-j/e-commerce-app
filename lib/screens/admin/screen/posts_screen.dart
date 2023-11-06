import 'package:e_commerce_app/screens/admin/screen/add_product_screen.dart';
import 'package:e_commerce_app/services/admin_services.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:e_commerce_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import '../widget/post_product_container.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<ProductModel>? products;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    fetchAllProducts();
    debugPrint("products 1= $products");
    super.initState();
  }

  void fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    debugPrint("products = $products");
    setState(() {});
  }

  void deleteProduct(ProductModel product, int index) async {
    adminServices.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          products!.removeAt(index);
          showSnackBar(context, "Product Deleted Successfully",isError: false);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: products == null
          ? const Loader()
          : products!.isEmpty
              ? const Center(
                  child: Text("No Products Added.."),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: products!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2 / 2.4),
                  itemBuilder: (context, index) {
                    final product = products![index];
                    return ProductContainer(
                      product: product,
                      onPressed: () => deleteProduct(product, index),
                    );
                  }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddProductScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

