import 'package:e_commerce_app/features/admin/screen/admin_screen.dart';
import 'package:e_commerce_app/features/auth/screens/auth_screen.dart';
import 'package:e_commerce_app/features/auth/services/auth_service.dart';
import 'package:e_commerce_app/features/home/screens/home_screen.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/router.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:e_commerce_app/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService _auth = AuthService();
  @override
  void initState() {
    _auth.getUserData(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<UserProvider>(context, listen: false)
        .user
        .token
        .toString());
    return MaterialApp(
        title: 'E-Commerce App',
        theme: ThemeData(
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            colorScheme: const ColorScheme.light(
                primary: GlobalVariables.secondaryColor),
            appBarTheme: const AppBarTheme(
                elevation: 0, iconTheme: IconThemeData(color: Colors.black))),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: AdminScreen()
        // home: Provider.of<UserProvider>(context).user.token.isNotEmpty
        //     ? Provider.of<UserProvider>(context).user.type == 'user'
        //         ? BottomNavBar()
        //         : AdminScreen()
        //     : AuthScreen()
            );
  }
}
