import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/provider/cart.dart';
import 'package:e_commerce/screens/user/product_info.dart';
import 'package:e_commerce/servises/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static String routName = 'CartScreen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? orderAddress;
  @override
  Widget build(BuildContext context) {
    List<ProductModel> products = Provider.of<CartProvider>(context).products;
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'your cart is empty, make your first order',
                    style: TextStyle(fontSize: 15, color: kMainColor),
                  ),
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
                            child: GestureDetector(
                              onTapUp: (details) {
                                double dx = details.globalPosition.dx;
                                double dy = details.globalPosition.dy;
                                double dx2 = MediaQuery.of(context).size.width -
                                    details.globalPosition.dx;
                                double dy2 =
                                    MediaQuery.of(context).size.height - dy;
                                showMenu(
                                    context: context,
                                    position:
                                        RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                                    items: [
                                      PopupMenuItem(
                                        child: const Text('Edit'),
                                        onTap: () async {
                                          // print('clicked');
                                          await Future.delayed(
                                              const Duration(milliseconds: 10));
                                          Navigator.of(context)
                                              .restorablePopAndPushNamed(
                                                  ProductInof.routName,
                                                  arguments: products[index]);
                                          Provider.of<CartProvider>(context,
                                                  listen: false)
                                              .products
                                              .remove(products[index]);
                                        },
                                      ),
                                      PopupMenuItem(
                                        child: const Text('Delete'),
                                        onTap: () {
                                          Provider.of<CartProvider>(context,
                                                  listen: false)
                                              .deleteFromCart(products[index]);
                                        },
                                      ),
                                    ]);
                              },
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
                    onPressed: () {
                      showCustomDialog(products, context);
                    },
                    child: const Text(
                      'ORDER',
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                  )
                ],
              ));
  }

  showCustomDialog(List<ProductModel> products, context) {
    AlertDialog alertDialog = AlertDialog(
      content: TextFormField(
        decoration: const InputDecoration(hintText: 'Address :'),
        onChanged: (value) {
          orderAddress = value;
        },
      ),
      title: Text('Total Price: ${calcTotalPrice(products)} \$'),
      actions: [
        MaterialButton(
          onPressed: () {
            MyStore _store = MyStore();
            _store.storeOrders({
              kAddress: orderAddress,
              kTotallPrice: calcTotalPrice(products),
            }, products);
          },
          child: const Text(
            'Confierm',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        )
      ],
    );
    showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  calcTotalPrice(List<ProductModel> products) {
    int totalPrice = 0;
    for (var i in products) {
      totalPrice += int.parse(i.pPrice!);
    }
    return totalPrice;
  }
}
