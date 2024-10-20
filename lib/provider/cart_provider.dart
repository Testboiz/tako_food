import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tako_food/model/cart_item.dart';
import 'package:tako_food/provider/cart_service.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;
  CartService cartService = CartService();
  final _user = FirebaseAuth.instance.currentUser;

  void addToCart(CartItem cartItem) {
    bool alreadyHasSameProduct = false;
    int? itemQuantity;
    for (CartItem item in _cartItems) {
      if (cartItem.product['name'] == item.product['name']) {
        alreadyHasSameProduct = true;
        itemQuantity = item.quantity;
      }
    }
    if (alreadyHasSameProduct && itemQuantity != null) {
      changeCartQuantity(cartItem, itemQuantity + 1);
    } else {
      _cartItems.add(cartItem);
    }

    cartService.addToCart(cartItem);
    notifyListeners();
  }

  Future<void> fetchCarts() async {
    List<CartItem> cartItems = await cartService.getCartItems(_user!.uid);
    _cartItems = cartItems;
    notifyListeners();
  }

  void buy() {
    cartService.addPurchase(cartItems, _user!.uid);
    clearCart();
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    _cartItems.removeWhere((item) => item == cartItem);
    cartService.deleteCart(cartItem, _user!.uid);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    cartService.clearCart(_user!.uid);
    notifyListeners();
  }

  void changeCartQuantity(CartItem cartItem, int newQuantity) {
    int cartItemToChangeIndex = _cartItems
        .indexWhere((item) => item.product['name'] == cartItem.product['name']);
    if (cartItemToChangeIndex == -1) {
      _cartItems.add(cartItem);
      cartService.addToCart(cartItem);
    } else {
      _cartItems[cartItemToChangeIndex].quantity = newQuantity;
      cartService.changeCartQuantity(cartItem, newQuantity);
    }
    notifyListeners();
  }

  String computeTotalAndReturnFormattedString() {
    int total = 0;
    for (CartItem cartItem in _cartItems) {
      total += cartItem.quantity * cartItem.product['price'] as int;
    }
    return NumberFormat.currency(locale: 'id-ID', symbol: "Rp").format(total);
  }
}
