import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/servises/database.dart';
import 'package:e_commerce/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  AddProduct({Key? key}) : super(key: key);
  static String routName = 'Adproduct';
  String? _name;
  String? _description;
  String? _imageLocation;
  String? _price;
  String? _category;
  int? _quantity;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                      'Add Product',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        _key.currentState!.save();
                        MyStore().addProduct(ProductModel(_name, _description,
                            _imageLocation, _price, _category, _quantity));
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
