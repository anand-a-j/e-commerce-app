import 'package:flutter/material.dart';

class CategoryDealsScreen extends StatefulWidget {
  final String category;
  const CategoryDealsScreen({super.key,required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      
    );
  }
}
