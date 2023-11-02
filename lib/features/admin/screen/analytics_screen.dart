import 'package:e_commerce_app/features/admin/model/sales_model.dart';
import 'package:e_commerce_app/features/admin/services/admin_services.dart';
import 'package:e_commerce_app/widgets/loader.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? sales;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  void getEarnings() async {
    var earnings = await adminServices.fetchEarnings(context);
    totalSales = earnings['totalEarnings'];
    sales = earnings['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return totalSales == null || sales == null ? Loader()
     : Column(
      children: [
        Text("Total Sales $totalSales"),
      ],
     );
  }
}
