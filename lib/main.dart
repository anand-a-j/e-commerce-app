import 'package:e_commerce_app/providers/address_provider.dart';
import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/providers/category_provider.dart';
import 'package:e_commerce_app/providers/home_provider.dart';
import 'package:e_commerce_app/providers/location_provider.dart';
import 'package:e_commerce_app/providers/onboarding_provider.dart';
import 'package:e_commerce_app/providers/order_provider.dart';
import 'package:e_commerce_app/providers/search_provider.dart';
import 'package:e_commerce_app/screens/onboarding/screen/onboarding_screen.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/router.dart';
import 'package:e_commerce_app/screens/splash/screen/splash_screen.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool onboardingCompleted = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  onboardingCompleted = prefs.getBool('onboardingCompleted') ?? false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => OnboardingProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => AddressProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'IShopTech',
        theme: ThemeData(
          useMaterial3: false,
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme:
              const ColorScheme.light(primary: GlobalVariables.primaryColor),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: onboardingCompleted ? const SplashScreen() : const OnboardingScreen());
  }
}
