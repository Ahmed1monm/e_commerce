import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/screens/admin/edit_product.dart';
import 'package:e_commerce/servises/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManageProduct extends StatefulWidget {
  static String routName = 'ManageProduct';
  const ManageProduct({Key? key}) : super(key: key);

  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  var id;
  final MyStore _store = MyStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadProducts(),
        builder: (context, snapshot) {
          List<ProductModel> products = [];
          if (snapshot.hasData) {
            for (var doc in snapshot.data!.docs) {
              id = doc.id;
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              products.add(
                ProductModel(
                    data[kProductName],
                    data[kProductDescription],
                    data[kProductLocation],
                    data[kProductPrice],
                    data[kProductCategory],
                    null),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.8,
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTapUp: (details) {
                      double dx = details.globalPosition.dx;
                      double dy = details.globalPosition.dy;
                      double dx2 = MediaQuery.of(context).size.width -
                          details.globalPosition.dx;
                      double dy2 = MediaQuery.of(context).size.height - dy;

                      showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                          items: [
                            PopupMenuItem(
                              child: const Text('Edit'),
                              onTap: () async {
                                print('clicked');
                                await Future.delayed(
                                    const Duration(milliseconds: 10));
                                Navigator.of(context).pushNamed(
                                    EditProduct.routName,
                                    arguments: {
                                      'product': products[index],
                                      'id': id
                                    });
                              },
                            ),
                            PopupMenuItem(
                              child: const Text('Delete'),
                              onTap: () {
                                _store.deleteProduct(id);
                              },
                            ),
                          ]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image(
                              image: AssetImage(products[index].pImageLocat!),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            width: MediaQuery.of(context).size.width,
                            child: Opacity(
                              opacity: 0.5,
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${products[index].pName}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text('${products[index].pPrice}\$',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: products.length,
              ),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text('snapshot doesnt has error ${snapshot.error}')),
            );
          } else {
            return const Text('والله ما عارف');
          }
        },
      ),
    );
  }
}
