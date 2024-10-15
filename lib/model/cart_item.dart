class CartItem {
  String userId;
  Map<String, dynamic> product;
  int quantity;
  String notes;

  CartItem({
    required this.userId,
    required this.product,
    required this.quantity,
    required this.notes,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      userId: map['user_id'] ?? '',
      product: map['product'] ?? {},
      quantity: map['quantity'] ?? 1, // default 1 item for quantity
      notes: map['notes'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'product': product,
      'quantity': quantity,
      'notes': notes,
    };
  }
}
