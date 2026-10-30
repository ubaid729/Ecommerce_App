import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/features/home/models/product_model.dart';
import 'package:flutter_application_1/features/product/models/review_model.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductModel product;

  ProductViewModel({required this.product}) {
    _loadProductData();
  }

  int _selectedImageIndex = 0;
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;
  int _quantity = 1;
  bool _isLoading = false;
  bool _isFavorite = false;
  List<ReviewModel> _reviews = [];

  // Getters
  int get selectedImageIndex => _selectedImageIndex;
  int get selectedColorIndex => _selectedColorIndex;
  int get selectedSizeIndex => _selectedSizeIndex;
  int get quantity => _quantity;
  bool get isLoading => _isLoading;
  bool get isFavorite => _isFavorite;
  List<ReviewModel> get reviews => _reviews;

  final List<String> availableSizes = const ['S', 'M', 'L', 'XL'];
  final List<int> availableColorValues = const [
    0xFF1E293B, // Charcoal
    0xFF2563EB, // Blue
    0xFFEF4444, // Red
    0xFF10B981, // Emerald
  ];

  void setSelectedImage(int index) {
    _selectedImageIndex = index;
    notifyListeners();
  }

  void setSelectedColor(int index) {
    _selectedColorIndex = index;
    notifyListeners();
  }

  void setSelectedSize(int index) {
    _selectedSizeIndex = index;
    notifyListeners();
  }

  void incrementQuantity() {
    _quantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }

  Future<void> _loadProductData() async {
    _isLoading = true;
    notifyListeners();

    // Mock network fetch for reviews & details
    await Future.delayed(const Duration(milliseconds: 300));

    _reviews = [
      ReviewModel(
        id: '1',
        userName: 'Alex Johnson',
        userAvatar: '',
        rating: 5.0,
        comment: 'Great build quality and feels super premium. Exceeded expectations!',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      ReviewModel(
        id: '2',
        userName: 'Sarah Williams',
        userAvatar: '',
        rating: 4.0,
        comment: 'Fast shipping and fits true to size. Color matches the pictures.',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }
}