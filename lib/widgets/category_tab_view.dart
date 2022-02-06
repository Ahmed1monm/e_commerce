import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/screens/user/product_info.dart';
import 'package:flutter/material.dart';

import 'category_product_home_show.dart';

class CategoryTabView extends StatelessWidget {
  const CategoryTabView(
      {Key? key, required this.categoryName, required this.generalProducts})
      : super(key: key);
  final String categoryName;
  final List<ProductModel> generalProducts;

  @override
  Widget build(BuildContext context) {
    List<ProductModel> filteredProductList =
        loadProductOfAspecieficCategory(generalProducts, categoryName);
    print(filteredProductList.length);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10, childAspectRatio: 0.8, crossAxisCount: 2),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProductInof.routName,
                  arguments: filteredProductList[index]);
            },
            child: HomeProductShow(
              imageLoc: filteredProductList[index].pImageLocat!,
              name: filteredProductList[index].pName!,
              price: filteredProductList[index].pPrice!,
            ),
          );
        },
        itemCount: filteredProductList.length,
      ),
    );
  }
}

loadProductOfAspecieficCategory(
    List<ProductModel> allProducts, String category) {
  List<ProductModel> productList = [];
  for (var product in allProducts) {
    if (product.pCategory == category) {
      productList.add(product);
    }
  }
  return productList;
}
