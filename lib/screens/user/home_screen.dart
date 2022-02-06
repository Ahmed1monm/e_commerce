import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/screens/user/cart_screen.dart';
import 'package:e_commerce/screens/user/product_info.dart';
import 'package:e_commerce/servises/database.dart';
import 'package:e_commerce/widgets/category_product_home_show.dart';
import 'package:e_commerce/widgets/category_tab_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static String routeName = 'HomeScreen';
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ProductModel> generalProducts = [];
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  final _store = MyStore();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _bottomBarIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                setState(() {
                  _bottomBarIndex = value;
                });
              },
              fixedColor: kMainColor,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'test'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'test'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.close), label: 'Sign out'),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: kMainColor,
                onTap: (value) {
                  setState(() {
                    _tabBarIndex = value;
                  });
                },
                tabs: [
                  Text(
                    'Jacets',
                    style: TextStyle(
                        color:
                            _tabBarIndex == 0 ? Colors.black : kUnActiveColor,
                        fontSize: _tabBarIndex == 0 ? 16 : null),
                  ),
                  Text(
                    'Trouser',
                    style: TextStyle(
                        color:
                            _tabBarIndex == 1 ? Colors.black : kUnActiveColor,
                        fontSize: _tabBarIndex == 1 ? 16 : null),
                  ),
                  Text(
                    'T-shirts',
                    style: TextStyle(
                        color:
                            _tabBarIndex == 2 ? Colors.black : kUnActiveColor,
                        fontSize: _tabBarIndex == 2 ? 16 : null),
                  ),
                  Text(
                    'Shoes',
                    style: TextStyle(
                        color:
                            _tabBarIndex == 3 ? Colors.black : kUnActiveColor,
                        fontSize: _tabBarIndex == 3 ? 16 : null),
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: [
                jacets(),
                CategoryTabView(
                    categoryName: kTrousers, generalProducts: generalProducts),
                CategoryTabView(
                    categoryName: kTshirts, generalProducts: generalProducts),
                CategoryTabView(
                    categoryName: kShoes, generalProducts: generalProducts),
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            // ignore: sized_box_for_whitespace
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'DISCOVER',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
        )
      ],
    );
  }

  Widget jacets() {
    // var id;
    return StreamBuilder<QuerySnapshot>(
      // here I am load all products
      stream: _store.loadProducts(),
      builder: (context, snapshot) {
        List<ProductModel> products = [];
        if (snapshot.hasData) {
          for (var document in snapshot.data!.docs) {
            // id = document.id;
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            products.add(ProductModel(
                data[kProductName],
                data[kProductDescription],
                data[kProductLocation],
                data[kProductPrice],
                data[kProductCategory],
                null));

            /* **************************************************************** */

            // generalProducts.add(ProductModel(
            //     data[kProductName],
            //     data[kProductDescription],
            //     data[kProductLocation],
            //     data[kProductPrice],
            //     data[kProductCategory]),
            //     );
          }
          // here i am finish loading

          generalProducts = [...products];

          // filtering products by category
          List<ProductModel> jacetsList =
              loadProductOfAspecieficCategory(products, kJackets);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.8,
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(ProductInof.routName,
                        arguments: jacetsList[index]);
                  },
                  child: HomeProductShow(
                    imageLoc: jacetsList[index].pImageLocat!,
                    name: jacetsList[index].pName!,
                    price: jacetsList[index].pPrice!,
                  ),
                );
              },
              itemCount: jacetsList.length,
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('wait');
        } else {
          print(snapshot.error);
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
