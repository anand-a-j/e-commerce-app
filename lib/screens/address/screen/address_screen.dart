import 'package:e_commerce_app/services/address_service.dart';
import 'package:e_commerce_app/screens/checkout/screen/checkout_screen.dart';
import 'package:e_commerce_app/router.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final double totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressFormKey = GlobalKey<FormState>();
  TextEditingController homeController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String addressToBeUsed = '';
  final AddressServices addressServices = AddressServices();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: true).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Address",
          style: TextStyle(color: GlobalVariables.blackColor),
        ),
        backgroundColor: GlobalVariables.backgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _addressFormKey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  CustomTextField(
                    controller: homeController,
                    hintText: "Flat, House No, Building",
                    autofocus: true,
                    inputType: TextInputType.streetAddress,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  CustomTextField(
                    controller: streetController,
                    hintText: "Area/Street",
                    inputType: TextInputType.streetAddress,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: CustomTextField(
                        controller: cityController,
                        hintText: "City",
                        inputType: TextInputType.streetAddress,
                      )),
                      Dimensions.kWidth10,
                      Expanded(
                        child: CustomTextField(
                          controller: stateController,
                          hintText: "State",
                          inputType: TextInputType.streetAddress,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  CustomTextField(
                    controller: pincodeController,
                    hintText: "Pincode",
                    inputType: TextInputType.number,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  CustomTextField(
                    controller: phoneController,
                    hintText: "Phone Number",
                    inputType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          CustomButton(
              title: "Next",
              onPressed: () {
                if (_addressFormKey.currentState!.validate()) {
                  addressToBeUsed =
                      '''${user.name}\n${homeController.text}\n${streetController.text}\n${cityController.text},${stateController.text}\n${pincodeController.text}\nPh: ${phoneController.text}''';

                  addressServices.saveUserAddress(
                      context: context, address: user.address);

                  Navigator.pushNamed(context, CheckoutScreen.routeName,
                      arguments: AddressArguments(
                          widget.totalAmount, addressToBeUsed));
                }
              })
        ],
      ),
    );
  }
}
