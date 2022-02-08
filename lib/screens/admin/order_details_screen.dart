import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/servises/database.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  static const String routName = 'OrderDetails';
  const OrderDetails({Key? key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  MyStore store = MyStore();

  @override
  Widget build(BuildContext context) {
    var decumentId = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: const Text('Order details'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: store.loadOrderDetails(decumentId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ProductModel> products = [];
              for (var doc in snapshot.data!.docs) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                products.add(ProductModel(
                    data[kProductName],
                    data[kProductDescription],
                    data[kProductLocation],
                    data[kProductPrice],
                    data[kProductCategory],
                    data[kProductQuantity]));
              }

              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .2,
                          color: kSecondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('product name : ${products[index].pName}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Quantity : ${products[index].quantity}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'product Category : ${products[index].pCategory}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      itemCount: products.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: ButtonTheme(
                            buttonColor: kMainColor,
                            child: MaterialButton(
                              color: kMainColor,
                              onPressed: () {},
                              child: const Text(
                                'Confirm Order',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ButtonTheme(
                            buttonColor: kMainColor,
                            child: MaterialButton(
                              color: kMainColor,
                              onPressed: () {},
                              child: const Text('Delete Order',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('Loading Order Details'),
              );
            }
          }),
    );
  }
}
