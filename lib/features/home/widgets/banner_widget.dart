import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  final List<String> bannerImages;

  const BannerWidget({
    super.key,
    required this.bannerImages,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return CarouselSlider.builder(
      itemCount: bannerImages.length,
      itemBuilder: (context, index, realIndex) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            bannerImages[index],
            width: double.infinity,
            fit: BoxFit.cover,
            cacheWidth: (screenWidth * 2).toInt(),
          ),
        );
      },
      options: CarouselOptions(
        height: screenWidth < 600 ? 180 : 220,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        enlargeCenterPage: true,
        viewportFraction: 0.92,
      ),
    );
  }
}