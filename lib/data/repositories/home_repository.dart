
import 'package:flutter_application_1/data/services/firestore_service.dart';
import 'package:flutter_application_1/features/home/models/category_model.dart';
import 'package:flutter_application_1/features/home/models/product_model.dart';

class HomeRepository {
  final FirestoreService _firestoreService;

  HomeRepository(this._firestoreService);

  // Get categories
  Future<List<CategoryModel>> getCategories() async {
    final snapshot = await _firestoreService.getCategories();

    return snapshot.docs.map((doc) {
      return CategoryModel.fromMap(
        doc.data(),
        doc.id,
      );
    }).toList();
  }

  // Get all products
  Future<List<ProductModel>> getProducts() async {
    final snapshot = await _firestoreService.getProducts();

    return snapshot.docs.map((doc) {
      return ProductModel.fromMap(
        doc.data(),
        doc.id,
      );
    }).toList();
  }

  // Get featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    final snapshot = await _firestoreService.getFeaturedProducts();

    return snapshot.docs.map((doc) {
      return ProductModel.fromMap(
        doc.data(),
        doc.id,
      );
    }).toList();
  }

  // Get flash sale products
  Future<List<ProductModel>> getFlashSaleProducts() async {
    final snapshot = await _firestoreService.getFlashSaleProducts();

    return snapshot.docs.map((doc) {
      return ProductModel.fromMap(
        doc.data(),
        doc.id,
      );
    }).toList();
  }
}