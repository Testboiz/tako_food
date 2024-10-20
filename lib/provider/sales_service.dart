import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tako_food/model/sales.dart';

class SalesService {
  final CollectionReference _sales =
      FirebaseFirestore.instance.collection('sales');

  Future<List<Sales>> getSales(String uid) async {
    try {
      QuerySnapshot snapshot =
          await _sales.where('user_id', isEqualTo: uid).get();
      return snapshot.docs
          .map((doc) => Sales.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (err) {
      log("Something Went Wrong : $err");
      return [];
    }
  }

  Future<void> deleteSalesHistory(String uid) async {
    QuerySnapshot qs = await _sales.where('user_id', isEqualTo: uid).get();
    if (qs.docs.isEmpty) {
      log("Sales is empty for this user");
      return;
    }
    for (QueryDocumentSnapshot doc in qs.docs) {
      await _sales
          .doc(doc.id)
          .delete()
          .then((value) => log("Sales cleared"))
          .catchError((e) => log(e));
    }
  }
}
