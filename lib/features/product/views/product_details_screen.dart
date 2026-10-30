import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/models/product_model.dart';
import 'package:flutter_application_1/features/product/viewmodels/product_viewmodel.dart';
import 'package:flutter_application_1/features/product/widgets/product_image_gallery.dart';
import 'package:flutter_application_1/features/product/widgets/product_info.dart';
import 'package:flutter_application_1/features/product/widgets/product_options.dart';
import 'package:flutter_application_1/features/product/widgets/quantity_selector.dart';
import 'package:flutter_application_1/features/product/widgets/review_section.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductViewModel(product: product),
      child: Consumer<ProductViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            backgroundColor: const Color(0xFFF8FAFC),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    vm.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: vm.isFavorite
                        ? const Color(0xFFEF4444)
                        : const Color(0xFF1E293B),
                  ),
                  onPressed: vm.toggleFavorite,
                ),
              ],
            ),
            body: vm.isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF2563EB)),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductImageGallery(
                          images: [product.imageUrl],
                          selectedIndex: vm.selectedImageIndex,
                          onSelect: vm.setSelectedImage,
                        ),
                        const SizedBox(height: 20),
                        ProductInfo(
                          title: product.name,
                          price: product.price,
                          description:
                              'Crafted with premium materials offering exceptional comfort and durability designed for everyday utility.',
                        ),
                        const SizedBox(height: 20),
                        ProductOptions(
                          colors: vm.availableColorValues,
                          selectedColorIndex: vm.selectedColorIndex,
                          onColorSelected: vm.setSelectedColor,
                          sizes: vm.availableSizes,
                          selectedSizeIndex: vm.selectedSizeIndex,
                          onSizeSelected: vm.setSelectedSize,
                        ),
                        const SizedBox(height: 24),
                        ReviewSection(reviews: vm.reviews),
                        const SizedBox(height: 80), // Padding for bottom bar
                      ],
                    ),
                  ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    QuantitySelector(
                      quantity: vm.quantity,
                      onIncrement: vm.incrementQuantity,
                      onDecrement: vm.decrementQuantity,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2563EB),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          minimumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Added ${vm.quantity}x ${product.name} to cart',
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}