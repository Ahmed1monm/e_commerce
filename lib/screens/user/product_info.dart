import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/provider/cart.dart';
import 'package:e_commerce/screens/user/cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductInof extends StatefulWidget {
  static String routName = 'productInfo';
  const ProductInof({Key? key}) : super(key: key);

  @override
  _ProductInofState createState() => _ProductInofState();
}

class _ProductInofState extends State<ProductInof> {
  int _quantity = 0;
  @override
  Widget build(BuildContext context) {
    ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image(
              image: AssetImage(product.pImageLocat!),
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            // ignore: sized_box_for_whitespace
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(CartScreen.routName);
                    },
                    child: const Icon(Icons.shopping_cart),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                Opacity(
                  opacity: 0.7,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.pName!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            product.pDiscription!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${product.pPrice!} \$',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: Material(
                                  color: kMainColor,
                                  child: GestureDetector(
                                    child: const Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Icon(Icons.add),
                                    ),
                                    onTap: increment,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                _quantity.toString(),
                                style: const TextStyle(
                                    fontSize: 80, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              ClipOval(
                                child: Material(
                                  color: kMainColor,
                                  child: GestureDetector(
                                    child: const Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Icon(Icons.remove),
                                    ),
                                    onTap: decrement,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                ButtonTheme(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  height: MediaQuery.of(context).size.height * 0.1,
                  minWidth: MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    color: kMainColor,
                    child: const Text(
                      'ADD TO CART',
                      style: TextStyle(fontSize: 30),
                    ),
                    onPressed: () {
                      product.quantity = _quantity;
                      Provider.of<CartProvider>(context, listen: false)
                          .addToCrt(product);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Product added successfully')));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  increment() {
    setState(() {
      _quantity++;
    });
  }

  decrement() {
    if (_quantity > 0) {
      setState(() {
        _quantity--;
      });
    }
  }
}
