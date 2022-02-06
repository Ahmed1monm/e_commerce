import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/admin/add_product.dart';
import 'package:e_commerce/screens/admin/manage_product.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  static String routeName = 'Menu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: kSecondaryColor,
              onPressed: () {
                Navigator.of(context).pushNamed(AddProduct.routName);
              },
              child: const Text(
                'Add Product',
              ),
            ),
            MaterialButton(
              color: kSecondaryColor,
              onPressed: () {
                Navigator.of(context).pushNamed(ManageProduct.routName);
              },
              child: const Text(
                'Edit Product',
              ),
            ),
            MaterialButton(
              color: kSecondaryColor,
              onPressed: () {},
              child: const Text(
                'View Product',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
