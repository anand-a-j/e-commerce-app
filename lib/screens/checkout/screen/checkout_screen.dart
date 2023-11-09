import 'dart:async';
import 'dart:developer';
import 'package:e_commerce_app/services/address_service.dart';
import 'package:e_commerce_app/screens/checkout/screen/order_success_screen.dart';
import 'package:e_commerce_app/models/order.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/utils/api.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../widgets/custom_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckoutScreen extends StatefulWidget {
  static const String routeName = '/checkout-screen';
  final double totalAmount;
  final String address;
  const CheckoutScreen(
      {super.key, required this.totalAmount, required this.address});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final AddressServices addressServices = AddressServices();
  List<Order>? orders;
  late Order order;
  final _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint("PAYMENT MADE SUCCESSFULLY");

    addressServices.placeOrder(
        context: context,
        address: widget.address,
        totalAmount: widget.totalAmount,
        paymentId: response.paymentId.toString());

    Navigator.pushNamedAndRemoveUntil(context, OrderSuccessScreen.routeName, (route) => false);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Timer(const Duration(seconds: 3), () {
      showSnackBar(context, "Payment Failed!!!");
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false).user;
    log(user.address.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.backgroundColor,
        centerTitle: true,
        title: const Text(
          "Checkout",
          style: TextStyle(color: GlobalVariables.blackColor),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 240,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Center(
              child: Lottie.asset(
                'assets/lottie/checkout.json',
                animate: true,
                repeat: true,
                fit: BoxFit.contain
                ),
            ),
              ),
            ),
            ListView(
              shrinkWrap: true,
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    "Shipping Address",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 0.7, color: Colors.grey)),
                    child: Text(
                      widget.address,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    "Products",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: user.cart!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 70,
                      width: double.infinity,
                      child: ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.purple.shade100,
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: NetworkImage(user.cart![index]['product']['images'][0]),
                                fit: BoxFit.cover),
                          ),
                        ),
                        title: Text(
                            user.cart![index]['product']['name'].toString()),
                        subtitle: Text(
                            "Quantity: ${user.cart![index]['quantity']}"),
                      ),
                    );
                  },
                ),
              ],
            ),
            const Spacer(),
            CustomButton(
              title: "Pay ₹${widget.totalAmount.toInt()}",
              onPressed: () {
                try {
                  var amountInPaisa = (widget.totalAmount * 100).toInt();
                  const description = 'Test Payment';
                  var options = {
                    'key': razorPayApiKey,
                    'amount': amountInPaisa,
                    'name': user.name,
                    'description': description,
                    'prefill': {
                      'contact': '8078811824',
                      'email': 'anandjayakumar2001@gmail.com'
                    }
                  };
                  try {
                    _razorpay.open(options);
                  } catch (e) {
                    debugPrint("ERRRRRRRRRRRRRRPR ${e.toString()}");
                  }
                } catch (e) {
                  log(e.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
