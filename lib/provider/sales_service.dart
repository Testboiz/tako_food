import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tako_food/model/sales.dart';

class ProductService {
  final CollectionReference _sales =
      FirebaseFirestore.instance.collection('sales');

  void addProduct(Sales salesItem) async {
    await _sales
        .add(salesItem.toMap())
        .then((value) => log("Success"))
        .catchError((err) => log("Something Went Wrong : $err"));
  }

  Future<List<Sales>> getProducts() async {
    try {
      QuerySnapshot snapshot = await _sales.get();
      return snapshot.docs
          .map((doc) => Sales.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (err) {
      log("Something Went Wrong : $err");
      return [];
    }
  }
}
