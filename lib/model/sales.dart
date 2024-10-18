class Sales {
  String userId;
  List<Map<String, dynamic>> products;
  DateTime saleDate;

  Sales({
    required this.userId,
    required this.products,
    required this.saleDate,
  });

  factory Sales.fromMap(Map<String, dynamic> map) {
    return Sales(
        userId: map['user_id'] ?? '',
        products:
            List<Map<String, dynamic>>.from(map['purchased_products'] ?? []),
        saleDate: DateTime.parse(map['purchase_datetime'].toDate().toString()));
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'purchased_products': products,
      'purchase_datetime': saleDate
    };
  }

  List<Map<String, dynamic>> toPurchasesMap() {
    List<Map<String, dynamic>> list = [];
    for (var item in products) {
      list.add({
        'date': saleDate.toString(),
        'item': item,
      });
    }
    return list;
  }
}
