import 'dart:developer';
// import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:tako_food/model/product.dart';

class ProductService {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('products');
  // final _storage = FirebaseStorage.instance;

  void addProduct(Product product) async {
    await _products
        .add(product.toMap())
        .then((value) => log("Success"))
        .catchError((err) => log("Something Went Wrong : $err"));
  }

  Future<List<Product>> getProducts() async {
    try {
      QuerySnapshot snapshot = await _products.get();
      return snapshot.docs
          .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (err) {
      log("Something Went Wrong : $err");
      return [];
    }
  }
}
