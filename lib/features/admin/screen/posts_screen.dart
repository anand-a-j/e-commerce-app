import 'package:e_commerce_app/features/admin/screen/add_product_screen.dart';
import 'package:e_commerce_app/features/admin/services/admin_services.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:e_commerce_app/widgets/loader.dart';
import 'package:flutter/material.dart';

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
          showSnackBar(context, "Product Deleted Successfully");
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: products == null
          ? Loader()
          : products!.isEmpty
              ? const Center(
                  child: Text("No Products Added.."),
                )
              : GridView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: products!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2 / 2.2),
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

class ProductContainer extends StatelessWidget {
  const ProductContainer({
    super.key,
    required this.product,
    required this.onPressed,
  });

  final ProductModel product;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
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
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              image: DecorationImage(
                  image: NetworkImage(product.images[0]), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(product.name),
          Text(product.price.toString()),
          OutlinedButton(onPressed: onPressed, child: const Text("Delete"))
        ],
      ),
    );
  }
}
