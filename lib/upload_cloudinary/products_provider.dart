import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:todo_ji/upload_cloudinary/products_model.dart';

import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<ProductModel> _products = [];
  List<ProductModel> get products => _products;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _error;
  String? get error => _error;
  final String cloudName = 'dglxnraim';
  final String uploadPreset = 'flutter_coffee_test';

  Future<String> uploadImageToCloudinary(XFile image) async {
    final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );
    final request = http.MultipartRequest('POST', url);
    request.fields['upload_preset'] = uploadPreset;
    final Uint8List bytes = await image.readAsBytes();
    request.files.add(
      http.MultipartFile.fromBytes('file', bytes, filename: image.name),
    );
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final data = jsonDecode(responseBody);
      return data['secure_url'];
    }
    throw Exception('Cloudinary upload failed: $responseBody');
  }

  Future<bool> addProduct({
    required XFile image,
    required String title,
    required String description,
    required double price,
  }) async {
    try {
      _isLoading = true;
      _error = null;

      notifyListeners();

      // Upload image to Cloudinary
      final String imageUrl = await uploadImageToCloudinary(image);

      // Create product model
      final product = ProductsModel(
        title: title,
        description: description,
        price: price,
        imageUrl: imageUrl,
      );

      // Save only product data + Cloudinary URL
      await _firestore.collection('products').add(product.toMap());

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchProducts() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      final snapshot = await _firestore.collection('products').get();
      _products.clear();
      for (final doc in snapshot.docs) {
        _products.add(ProductModel.fromMap(doc.data(), doc.id));
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  Stream<List<ProductsModel>> getProductsStream() {
    return _firestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductsModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<bool> deleteProduct(String productId) async {
    try {
      _isLoading = true;
      _error = null;

      notifyListeners();

      await _firestore.collection('products').doc(productId).delete();

      _products.removeWhere((product) => product.id == productId);

      return true;
    } catch (e) {
      _error = e.toString();

      debugPrint('Delete Product Error: $e');

      return false;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }
}
