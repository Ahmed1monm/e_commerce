import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static String routName = 'CartScreen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    List<ProductModel> products = Provider.of<CartProvider>(context).products;
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            'My Cart',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: products.isEmpty
            ? const Center(
                child: Text(
                  'your cart is empty, make your first order',
                  style: TextStyle(fontSize: 30, color: kMainColor),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: kSecondaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Image(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        products[index].pImageLocat!)),
                              ),
                              title: Text(products[index].pName!),
                              subtitle: Text(products[index].pDiscription!),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${products[index].pPrice!} \$'),
                                  Text(
                                      'Quantity ${products[index].quantity.toString()} '),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: products.length,
                    ),
                  ),
                  MaterialButton(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    color: kMainColor,
                    minWidth: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.06,
                    onPressed: () {},
                    child: const Text(
                      'ORDER',
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                  )
                ],
              ));
  }
}
