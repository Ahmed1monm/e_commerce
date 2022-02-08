import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/order_model.dart';
import 'package:e_commerce/screens/admin/order_details_screen.dart';
import 'package:e_commerce/servises/database.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  static const String routName = 'ordersScreen';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final MyStore _store = MyStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context, snapshot) {
          List<OrderModel> orders = [];
          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'There is no orders rightnow',
                style: TextStyle(color: kMainColor, fontSize: 15),
              ),
            );
          } else {
            for (var doc in snapshot.data!.docs) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              orders.add(OrderModel(data[kAddress].toString(),
                  data[kTotallPrice].toString(), doc.id));
            }
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(OrderDetails.routName,
                        arguments: orders[index].id);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * .2,
                    color: kSecondaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Totall Price = \$${orders[index].price}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Address is ${orders[index].address}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: orders.length,
          );
        },
      ),
    );
  }
}
