import 'package:e_commerce_app/features/admin/model/sales_model.dart';
import 'package:e_commerce_app/features/admin/services/admin_services.dart';
import 'package:e_commerce_app/features/admin/widget/bar_chart.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
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
    print("8547 total ==> ${earnings['totalEarnings']}");
    totalSales = earnings['totalEarnings'];
    sales = earnings['sales'];
    print(sales!.length);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return totalSales == null || sales == null
        ? Loader()
        : Column(
            children: [
              Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: GlobalVariables.primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Sales",
                      style: TextStyle(
                          color: GlobalVariables.backgroundColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    Text(
                      "₹ $totalSales",
                      style: const TextStyle(
                          color: GlobalVariables.backgroundColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ],
                ),
              ),
              CategoryWiseSalesChart(sales: sales,)
            ],
          );
  }
}
