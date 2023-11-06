import 'package:e_commerce_app/screens/admin/model/sales_model.dart';
import 'package:e_commerce_app/services/admin_services.dart';
import 'package:e_commerce_app/screens/admin/widget/bar_chart.dart';
import 'package:e_commerce_app/screens/admin/widget/category_sum_container.dart';
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
    totalSales = earnings['totalEarnings'];
    sales = earnings['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return totalSales == null || sales == null
        ? const Loader()
        : ListView(
            children: [
              Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 95, 202, 98),
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
              CategoryWiseSalesChart(
                sales: sales,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: sales!.length,
                  itemBuilder: (context, index) {
                    return CategoryWiseSumContainer(
                        title: sales![index].label,
                        amount: sales![index].earning.toString()
                    );
                  })
            ],
          );
  }
}

