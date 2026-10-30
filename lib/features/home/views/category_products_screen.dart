import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/models/category_model.dart';
import 'package:flutter_application_1/features/home/viewmodels/home_viewmodel.dart';
import 'package:flutter_application_1/features/home/widgets/product_card.dart';
import 'package:provider/provider.dart';

class CategoryProductsScreen extends StatelessWidget {
  final CategoryModel category;

  const CategoryProductsScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          category.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
      ),

      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {

          final categoryProducts = viewModel.products
              .where(
                (product) => product.categoryId == category.id,
              )
              .toList();

          if (categoryProducts.isEmpty) {
            return const Center(
              child: Text(
                'No products found',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF64748B),
                ),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: categoryProducts.length,

            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: 250,
            ),

            itemBuilder: (context, index) {
              final product = categoryProducts[index];

              return ProductCard(
                product: product,
                onTap: () {},
                onFavoriteTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}