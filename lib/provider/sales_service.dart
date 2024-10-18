import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tako_food/model/sales.dart';

class SalesService {
  final CollectionReference _sales =
      FirebaseFirestore.instance.collection('sales');

  Future<List<Sales>> getSales() async {
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
