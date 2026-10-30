import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/viewmodels/home_viewmodel.dart';
import 'package:flutter_application_1/features/home/views/category_products_screen.dart';
import 'package:flutter_application_1/features/home/widgets/category_card.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Categories',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
      ),

      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {

          // Loading
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF2563EB),
              ),
            );
          }

          // Error
          if (viewModel.errorMessage != null) {
            return Center(
              child: Text(
                viewModel.errorMessage!,
                style: const TextStyle(
                  color: Color(0xFFEF4444),
                ),
              ),
            );
          }

          // No categories
          if (viewModel.categories.isEmpty) {
            return const Center(
              child: Text(
                'No categories found',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF64748B),
                ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),

            child: GridView.builder(
              itemCount: viewModel.categories.length,

              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                mainAxisExtent: 150,
              ),

             itemBuilder: (context, index) {
  final category = viewModel.categories[index];
               return CategoryCard(
    category: category,
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryProductsScreen(
            category: category,
          ),
        ),
      ); },
  );
},
              
            
            ),
          );
        },
      ),
    );
  }
}