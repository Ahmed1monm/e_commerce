import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/product_model.dart';

class MyStore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  addProduct(ProductModel product) {
    _firestore.collection(kProductsCollection).add({
      kProductName: product.pName,
      kProductCategory: product.pCategory,
      kProductLocation: product.pImageLocat,
      kProductDescription: product.pDiscription,
      kProductPrice: product.pPrice
    });
  }

  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection(kProductsCollection).snapshots();
  }

  deleteProduct(var docId) {
    _firestore.collection(kProductsCollection).doc(docId).delete();
  }

  editProduct(data, var docId) {
    _firestore.collection(kProductsCollection).doc(docId).update(data);
  }

  storeOrders(data, List<ProductModel> products) {
    var docRef = _firestore.collection(kOrders).doc();
    docRef.set(data);

    for (var product in products) {
      docRef.collection(kOrderDetails).doc().set({
        kProductName: product.pName,
        kProductPrice: product.pPrice,
        kProductQuantity: product.quantity,
        kProductCategory: product.pCategory,
        kProductLocation: product.pImageLocat,
      });
    }
  }

  Stream<QuerySnapshot> loadOrders() {
    return _firestore.collection(kOrders).snapshots();
  }

  Stream<QuerySnapshot> loadOrderDetails(documentId) {
    return _firestore
        .collection(kOrders)
        .doc(documentId)
        .collection(kOrderDetails)
        .snapshots();
  }
}
