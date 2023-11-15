import 'package:e_commerce_app/providers/category_provider.dart';
import 'package:e_commerce_app/screens/category/widget/category_product_container.dart';
import 'package:e_commerce_app/screens/category/widget/empty_product.dart';
import 'package:e_commerce_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDealsScreen extends StatelessWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false)
          .fetchCategoryProducts(context, category);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: Consumer<CategoryProvider>(builder: (context, category, _) {
        return category.isLoading
            ? const Loader()
            : category.productList.isEmpty
                ? const EmptyProduct()
                : GridView.builder(
                    itemCount: category.productList.length,
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      final product = category.productList[index];
                      return CategoryProductsWidget(product: product,category: category);
                    });
      }),
    );
  }
}

