class Sales {
  String userId;
  List<Map<String, dynamic>> products;

  Sales({
    required this.userId,
    required this.products,
  });

  factory Sales.fromMap(Map<String, dynamic> map) {
    return Sales(
      userId: map['userId'] ?? '',
      products: List<Map<String, dynamic>>.from(map['products'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'products': products,
    };
  }
}
