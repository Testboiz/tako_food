import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tako_food/model/cart_item.dart';

class ProductService {
  final CollectionReference _carts =
      FirebaseFirestore.instance.collection('cart');

  void addProduct(CartItem cartItem) async {
    await _carts
        .add(cartItem.toMap())
        .then((value) => log("Success"))
        .catchError((err) => log("Something Went Wrong : $err"));
  }

  Future<List<CartItem>> getProducts() async {
    try {
      QuerySnapshot snapshot = await _carts.get();
      return snapshot.docs
          .map((doc) => CartItem.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (err) {
      log("Something Went Wrong : $err");
      return [];
    }
  }

  void clearCart(String uid) async {
    try {
      QuerySnapshot qs = await _carts.where('user_id', isEqualTo: uid).get();
      if (qs.docs.isEmpty) {
        log("Cart is empty for this user");
        return;
      }

      for (QueryDocumentSnapshot doc in qs.docs) {
        await _carts
            .doc(doc.id)
            .delete()
            .then((value) => log("Cart cleared"))
            .catchError((e) => log(e));
      }
    } catch (err) {
      log("Something Went Wrong : $err");
    }
  }
}
