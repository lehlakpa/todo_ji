import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_ji/models/product_model.dart';

class ProductService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<ProductModel> products = [];
  bool isLoading = false;

  void fetchProducts() {
    _firestore.collection("products").snapshots().listen((snapshot) {
      products = snapshot.docs.map((doc) {
        return ProductModel.fromMap(doc.data(), doc.id);
      }).toList();
      notifyListeners();
    });
  }

  Future<void> addProduct(ProductModel prodct) async {
    isLoading = true;
    notifyListeners();
    await _firestore.collection("products").add(prodct.toMap());
    isLoading = false;
    notifyListeners();
  }

  Future<void> updateProduct(ProductModel prodct) async {
    isLoading = true;
    notifyListeners();
    await _firestore
        .collection("products")
        .doc(prodct.id)
        .update(prodct.toMap());
    isLoading = false;
    notifyListeners();
  }

  Future<void> DeleteProduct(String id) async {
    await _firestore.collection("products").doc(id).delete();
  }

  // void search(String keyWord) {
  //   if (keyWord.isEmpty) {
  //     seaarchProducts = List.from(products);
  //   } else {
  //     searchProducts = products.where(product);
  //   }
  // }
}
