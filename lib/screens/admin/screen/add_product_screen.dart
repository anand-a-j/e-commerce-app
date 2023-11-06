import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/services/admin_services.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();

  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();
  String? category;

  List<String> productCategory = [
    'SmartPhone',
    'Laptop',
    'Tablet',
    'Speakers',
    'SmartWatch'
  ];

  void selectImages() async {
    try {
      var result = await pickImages();
      setState(() {
        images = result;
      });
    } catch (e) {
      debugPrint("selectImage issue =${e.toString()}");
    }
  }

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
          context: context,
          name: nameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: double.parse(quantityController.text),
          category: category ?? 'Laptop',
          images: images);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map((image) {
                          return Builder(builder: (context) {
                            return Image.file(
                              image,
                              fit: BoxFit.cover,
                            );
                          });
                        }).toList(),
                        options:
                            CarouselOptions(height: 200, viewportFraction: 1))
                    : InkWell(
                        onTap: selectImages,
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.7,
                                  color: GlobalVariables.selectedNavBarColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_front,
                                  size: 42,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Add Product Image",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                    controller: nameController, hintText: "Product Name"),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: descriptionController,
                  hintText: "Description",
                  maxLines: 5,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(controller: priceController, hintText: "Price"),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                    controller: quantityController, hintText: "Quantity"),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      hint: const Text("Select the category"),
                      value: category,
                      items: productCategory.map((String item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          category = newValue!;
                        });
                      }),
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomButton(title: "Sell", onPressed: sellProduct),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
