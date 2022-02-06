import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  List<ProductModel> products = [];
  addToCrt(ProductModel product) {
    products.add(product);
    notifyListeners();
  }
}
