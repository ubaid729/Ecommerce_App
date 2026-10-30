import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/data/repositories/home_repository.dart';
import 'package:flutter_application_1/features/home/models/category_model.dart';
import 'package:flutter_application_1/features/home/models/product_model.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeRepository _repository;

  HomeViewModel(this._repository);

  bool _isLoading = false;
  String? _errorMessage;

  List<CategoryModel> _categories = [];
  List<ProductModel> _products = [];
  List<ProductModel> _featuredProducts = [];
  List<ProductModel> _flashSaleProducts = [];

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  List<CategoryModel> get categories => _categories;

  List<ProductModel> get products => _products;

  List<ProductModel> get featuredProducts => _featuredProducts;

  List<ProductModel> get flashSaleProducts => _flashSaleProducts;

  Future<void> loadHomeData() async {
    _isLoading = true;
    _errorMessage = null;

    notifyListeners();

    try {
      final results = await Future.wait([
        _repository.getCategories(),
        _repository.getProducts(),
        _repository.getFeaturedProducts(),
        _repository.getFlashSaleProducts(),
      ]);

      _categories = results[0] as List<CategoryModel>;
      _products = results[1] as List<ProductModel>;
      _featuredProducts = results[2] as List<ProductModel>;
      _flashSaleProducts = results[3] as List<ProductModel>;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }
}