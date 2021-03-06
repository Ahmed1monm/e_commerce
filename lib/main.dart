import 'package:e_commerce/provider/admin_mode.dart';
import 'package:e_commerce/provider/cart.dart';
import 'package:e_commerce/provider/model_hud.dart';
import 'package:e_commerce/screens/admin/add_product.dart';
import 'package:e_commerce/screens/admin/edit_product.dart';
import 'package:e_commerce/screens/admin/manage_product.dart';
import 'package:e_commerce/screens/admin/menu.dart';
import 'package:e_commerce/screens/admin/order_details_screen.dart';
import 'package:e_commerce/screens/admin/orders_screen.dart';
import 'package:e_commerce/screens/user/cart_screen.dart';
import 'package:e_commerce/screens/user/home_screen.dart';
import 'package:e_commerce/screens/login_screen.dart';
import 'package:e_commerce/screens/register_screen.dart';
import 'package:e_commerce/screens/user/product_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(
            home: Scaffold(
              body: Text(
                'Loading ....',
              ),
            ),
          );
        } else {
          isUserLoggedIn = snapshot.data!.getBool(kKeepMeLoggedIn) ?? false;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => CartProvider()),
              ChangeNotifierProvider(create: (context) => ModelHud()),
              ChangeNotifierProvider(create: (context) => AdminMode()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute:
                  isUserLoggedIn ? Home.routeName : LoginScreen.routName,
              routes: {
                OrderDetails.routName: (context) => const OrderDetails(),
                OrderScreen.routName: (context) => const OrderScreen(),
                CartScreen.routName: (context) => const CartScreen(),
                ProductInof.routName: (context) => const ProductInof(),
                Home.routeName: (context) => const Home(),
                EditProduct.routName: (context) => EditProduct(),
                LoginScreen.routName: (context) => const LoginScreen(),
                Register.routName: (context) => const Register(),
                AddProduct.routName: (context) => AddProduct(),
                Menu.routeName: (context) => const Menu(),
                ManageProduct.routName: (context) => const ManageProduct(),
              },
            ),
          );
        }
      },
    );
  }
}
