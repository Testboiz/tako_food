class Product {
  String name;
  String description;
  int price;
  String type;
  int spiceLevel;
  List<String> picUrl;
  double rating;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.type,
    required this.spiceLevel,
    required this.picUrl,
    required this.rating,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? 0,
      type: map["type"] ?? "Other",
      spiceLevel: map['spice_level'] ?? -1,
      picUrl: List<String>.from(map['pic_url'] ?? []),
      rating: map['rating'] ?? 5.0, // defaults to 5 star rating
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'type': type,
      'spice_level': spiceLevel,
      'pic_url': picUrl,
      'rating': rating,
    };
  }
}
