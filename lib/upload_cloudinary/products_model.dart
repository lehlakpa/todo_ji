class ProductsModel {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  ProductsModel({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory ProductsModel.fromMap(Map<String, dynamic> map, String id) {
    return ProductsModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
