class ProductModel {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String categoryId;
  final double rating;
  final bool isFeatured;
  final bool isFlashSale;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    this.rating = 0.0,
    this.isFeatured = false,
    this.isFlashSale = false,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map, String documentId) {
    return ProductModel(
      id: documentId,
      name: map['name'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      categoryId: map['categoryId'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      isFeatured: map['isFeatured'] ?? false,
      isFlashSale: map['isFlashSale'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
      'rating': rating,
      'isFeatured': isFeatured,
      'isFlashSale': isFlashSale,
    };
  }
}