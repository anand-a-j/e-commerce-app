import 'package:e_commerce_app/features/address/service/address_service.dart';
import 'package:e_commerce_app/features/auth/widgets/custom_button.dart';
import 'package:e_commerce_app/features/auth/widgets/custom_textfield.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pay/pay.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressFormKey = GlobalKey<FormState>();
  TextEditingController homeController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  // List<PaymentItem> paymentItems = [];

  // void onGooglePayResult(paymentResult) {
  //   debugPrint(paymentResult.toString());
  // }

  String addressToBeUsed = '';
  final AddressServices addressServices = AddressServices();
  

  @override
  Widget build(BuildContext context) {
   var address =
        Provider.of<UserProvider>(context, listen: true).user.address; 
   
    return Scaffold(
      appBar: AppBar(title: const Text("Address Screen")),
      body: Column(
        children: [
          Form(
            key: _addressFormKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  color: Colors.amber.shade100,
                  child: Text(address),
                ),
                CustomTextField(
                    controller: homeController,
                    hintText: "Flat, House no,Building"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                CustomTextField(
                    controller: streetController, hintText: "Area/street"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                CustomTextField(
                    controller: pincodeController, hintText: "pincode"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                CustomTextField(controller: cityController, hintText: "city"),
                CustomButton(
                    label: "Next",
                    onTap: (){
                      if (_addressFormKey.currentState!.validate()) {
                        addressToBeUsed =
                            '${homeController.text},${streetController.text},${cityController.text},${pincodeController.text}';
                        addressServices.saveUserAddress(
                            context: context, address: address);
                        debugPrint("User address => $addressToBeUsed");

                      addressServices.placeOrder(
                            context: context,
                            address: addressToBeUsed,
                            totalAmount: 1700.0
                            );
                        
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text("Add Address")),
    );
  }
}
