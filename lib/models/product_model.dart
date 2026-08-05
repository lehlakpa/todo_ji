class ProductModel {
  final String id;
  final String title;
  final double price;

  ProductModel({required this.id, required this.title, required this.price});

  Map<String, dynamic> toMap() {
    return {"title": title, "price": price};
  }

  factory ProductModel.fromMap(Map<String, dynamic> map, String id) {
    return ProductModel(
      id: id,
      title: map["title"] ?? "",
      price: (map["price"] as num).toDouble(),
    );
  }
}
