import 'package:e_commerce_app/screens/account/screen/account_screen.dart';
import 'package:e_commerce_app/screens/address/screen/address_screen.dart';
import 'package:e_commerce_app/screens/login/screen/sign_in_screen.dart';
import 'package:e_commerce_app/screens/sign_up/screen/sign_up_screen.dart';
import 'package:e_commerce_app/screens/cart/screen/cart_screen.dart';
import 'package:e_commerce_app/screens/checkout/screen/checkout_screen.dart';
import 'package:e_commerce_app/screens/checkout/screen/order_success_screen.dart';
import 'package:e_commerce_app/screens/category/screen/category_deals_screen.dart';
import 'package:e_commerce_app/screens/home/screens/home_screen.dart';
import 'package:e_commerce_app/screens/order_details/screen/order_details_screen.dart';
import 'package:e_commerce_app/screens/order_details/screen/orders_screen.dart';
import 'package:e_commerce_app/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:e_commerce_app/screens/product_details/screens/product_details_screen.dart';
import 'package:e_commerce_app/screens/search/screens/search_screen.dart';
import 'package:e_commerce_app/models/order.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignInScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SignInScreen());
    case SignUpScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SignUpScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomNavBar());
        case AccountScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AccountScreen());
    case CartScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const CartScreen());
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryDealsScreen(category: category));
    case SearchScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SearchScreen());
    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as ProductModel;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetailsScreen(
                product: product,
              ));
    case AddressScreen.routeName:
      var total = routeSettings.arguments as double;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => AddressScreen(totalAmount: total));
    case CheckoutScreen.routeName:
      AddressArguments arguments = routeSettings.arguments as AddressArguments;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CheckoutScreen(
                totalAmount: arguments.total,
                address: arguments.address,
              )
              );
        case OrdersScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const OrdersScreen());
    case OrderSuccessScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const OrderSuccessScreen());
    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => OrderDetailsScreen(order: order));
        case PrivacyPolicyScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const PrivacyPolicyScreen());
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Something went wrong"),
          ),
        ),
      );
  }
}

class AddressArguments {
  final double total;
  final String address;

  AddressArguments(this.total, this.address);
}
