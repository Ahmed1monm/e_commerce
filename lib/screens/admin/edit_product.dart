import 'package:e_commerce/servises/database.dart';
import 'package:e_commerce/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class EditProduct extends StatelessWidget {
  EditProduct({Key? key}) : super(key: key);

  static String routName = 'EditProduct';
  // String? _id;
  String? _name;
  String? _description;
  String? _imageLocation;
  String? _price;
  String? _category;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var product = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      backgroundColor: kMainColor,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                CustomTextField(
                  hint: 'Product name',
                  icon: Icons.add,
                  onClick: (value) {
                    _name = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: 'Price',
                  icon: Icons.attach_money_sharp,
                  onClick: (value) {
                    _price = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: 'Discriptiopn',
                  icon: Icons.info_outline,
                  onClick: (value) {
                    _description = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: 'Category',
                  icon: Icons.category,
                  onClick: (value) {
                    _category = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: 'Image location',
                  icon: Icons.image_search,
                  onClick: (value) {
                    _imageLocation = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                    color: Colors.white,
                    child: const Text(
                      'Update Product',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        _key.currentState!.save();
                        MyStore().editProduct({
                          kProductName: _name,
                          kProductPrice: _price,
                          kProductLocation: _imageLocation,
                          kProductDescription: _description,
                          kProductCategory: _category
                        }, product['id']);
                        _key.currentState!.reset();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('There is a problem try again')));
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
