import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/viewmodels/home_viewmodel.dart';
import 'package:flutter_application_1/features/home/views/categories_screen.dart';
import 'package:flutter_application_1/features/home/views/category_products_screen.dart';
import 'package:flutter_application_1/features/home/widgets/banner_widget.dart';
import 'package:flutter_application_1/features/home/widgets/category_card.dart';
import 'package:flutter_application_1/features/home/widgets/product_card.dart';
import 'package:flutter_application_1/features/home/widgets/section_title.dart';
import 'package:flutter_application_1/features/product/views/product_details_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final horizontalPadding = screenWidth < 600 ? 16.0 : 24.0;

    final productGridCount = screenWidth >= 1000
        ? 4
        : screenWidth >= 700
            ? 3
            : 2;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Hello, User 👋',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person_outline,
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),

      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF2563EB),
              ),
            );
          }

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

          return SingleChildScrollView(
            padding: EdgeInsets.all(horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      hintStyle: TextStyle(
                        color: Color(0xFF64748B),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF64748B),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Banner
                const BannerWidget(
                  bannerImages: [
                    'assets/images/banner1.jpg',
                    'assets/images/banner2.jpg',
                    'assets/images/banner3.jpg',
                  ],
                ),

                const SizedBox(height: 24),

                // Categories
                SectionTitle(
                  title: 'Categories',
                  onActionTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoryScreen(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: viewModel.categories.length,
                    itemBuilder: (context, index) {
                      final category = viewModel.categories[index];

                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: CategoryCard(
                          category: category,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CategoryProductsScreen(
                                  category: category,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Flash Sale
                SectionTitle(
                  title: 'Flash Sale',
                  onActionTap: () {},
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 270,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: viewModel.flashSaleProducts.length,
                    itemBuilder: (context, index) {
                      final product =
                          viewModel.flashSaleProducts[index];

                      return SizedBox(
                        width: 170,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: ProductCard(
                            product: product,
                            onTap: () {},
                            onFavoriteTap: () {},
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Featured
                SectionTitle(
                  title: 'Featured Products',
                  onActionTap: () {},
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 270,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: viewModel.featuredProducts.length,
                    itemBuilder: (context, index) {
                      final product =
                          viewModel.featuredProducts[index];

                      return SizedBox(
                        width: 170,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: ProductCard(
  product: product,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(product: product),
      ),
    );
  },
  onFavoriteTap: () {},
)
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // All Products
                SectionTitle(
                  title: 'All Products',
                  onActionTap: () {},
                ),

                const SizedBox(height: 12),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: viewModel.products.length,
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: productGridCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 270,
                  ),
                  itemBuilder: (context, index) {
                    final product = viewModel.products[index];

                    return ProductCard(
                      product: product,
                      onTap: () {},
                      onFavoriteTap: () {},
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}