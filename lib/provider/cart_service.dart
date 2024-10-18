import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tako_food/model/cart_item.dart';

class CartService {
  final CollectionReference _carts =
      FirebaseFirestore.instance.collection('cart');

  void addToCart(CartItem cartItem) async {
    bool entriesAlreadyExist = false;
    QuerySnapshot snapshot = await _carts
        .where("product.name", isEqualTo: cartItem.product['name'])
        .where("user_id", isEqualTo: cartItem.userId)
        .get();

    entriesAlreadyExist = snapshot.size > 0;

    if (entriesAlreadyExist) {
      changeCartQuantity(cartItem, cartItem.quantity + 1);
    } else {
      await _carts.add(cartItem.toMap());
    }
  }

  Future<List<CartItem>> getCartItems(String uid) async {
    try {
      QuerySnapshot snapshot =
          await _carts.where("user_id", isEqualTo: uid).get();
      List<CartItem> cartItems = snapshot.docs
          .map((doc) => CartItem.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return cartItems;
    } catch (err) {
      log("Something Went Wrong : $err");
      return [];
    }
  }

  Future<void> changeCartQuantity(CartItem cartItem, int newQuantity) async {
    QuerySnapshot selectedCart = await _carts
        .where('product.name', isEqualTo: cartItem.product['name'])
        .where("user_id", isEqualTo: cartItem.userId)
        .get();

    if (selectedCart.docs.isNotEmpty) {
      await _carts
          .doc(selectedCart.docs.first.id)
          .update({'quantity': newQuantity});
    }
  }

  void deleteCart(CartItem cartItem, String uid) async {
    QuerySnapshot qs = await _carts.where('user_id', isEqualTo: uid).get();
    if (qs.docs.isEmpty) {
      log("Cart is empty for this user");
      return;
    }
    await _carts.doc(qs.docs.first.id).delete();
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
