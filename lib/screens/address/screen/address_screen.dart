import 'package:e_commerce_app/providers/address_provider.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatelessWidget {
  static const String routeName = '/address';
  final double totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Address",
          style: TextStyle(color: GlobalVariables.blackColor),
        ),
        backgroundColor: GlobalVariables.backgroundColor,
      ),
      body: _addressBody(),
    );
  }

  Consumer<AddressProvider> _addressBody() {
    return Consumer<AddressProvider>(builder: (context, address, _) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: address.addressFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  CustomTextField(
                    controller: address.homeController,
                    hintText: "Flat, House No, Building",
                    autofocus: true,
                    inputType: TextInputType.streetAddress,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  CustomTextField(
                    controller: address.streetController,
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
                        controller: address.cityController,
                        hintText: "City",
                        inputType: TextInputType.streetAddress,
                      )),
                      Dimensions.kWidth10,
                      Expanded(
                        child: CustomTextField(
                          controller: address.stateController,
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
                    controller: address.pincodeController,
                    hintText: "Pincode",
                    inputType: TextInputType.number,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  CustomTextField(
                    controller: address.phoneController,
                    hintText: "Phone Number",
                    inputType: TextInputType.number,
                  ),
                  address.isLoading
                      ? Container(
                          margin: const EdgeInsets.all(10),
                          height: 30,
                          width: 30,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            address.updateCurrentLocation(context);
                          },
                          child: const Text("Current Location"),
                        )
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomButton(
                title: "Next",
                onPressed: () {
                  Provider.of<AddressProvider>(context, listen: false)
                      .checkoutAddress(context, totalAmount);
                }),
          ),
        ],
      );
    });
  }
}
