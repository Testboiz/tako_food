class CartItem {
  String userId;
  Map<String, dynamic> product;
  int quantity;

  CartItem({
    required this.userId,
    required this.product,
    required this.quantity,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      userId: map['userId'] ?? '',
      product: map['product'] ?? {},
      quantity: map['quantity'] ?? 1, // default 1 item for quantity
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'product': product,
      'quantity': quantity,
    };
  }
}
