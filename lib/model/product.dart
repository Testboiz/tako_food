class Product {
  String name;
  String description;
  int price;
  List<String> picUrl;
  List<String> tags;
  double rating;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.picUrl,
    required this.tags,
    required this.rating,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? 0,
      picUrl: List<String>.from(map['picUrl'] ?? []),
      tags: List<String>.from(map['tags'] ?? []),
      rating: map['rating'] ?? 5.0, // defaults to 5 star rating
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'picUrl': picUrl,
      'tags': tags,
      'rating': rating,
    };
  }
}
