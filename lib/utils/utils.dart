import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showSnackBar(BuildContext context, String message,{bool isError = true}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      backgroundColor: isError ? Colors.red : Colors.green,
      dismissDirection: DismissDirection.horizontal,
    ),
  );
}


String dateConvert(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  String formattedDate = DateFormat('dd/MM/yyyy').format(date);
  return formattedDate;
}

Widget orderStatus(int status) {
  switch (status) {
    case 1:
      return Chip(
        backgroundColor: Colors.blue.shade200,
        label: const Text(
          "Packed",
        ),
      );
    case 2:
      return Chip(
        backgroundColor: Colors.purple.shade200,
        label: const Text(
          "Shipping",
        ),
      );
    case 3:
      return Chip(
        backgroundColor: Colors.green.shade200,
        label: const Text(
          "Delivered",
        ),
      );
    default:
      return Chip(
        backgroundColor: Colors.orange.shade200,
        label: const Text("Pending"),
      );
  }
}
