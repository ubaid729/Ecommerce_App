import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  final String title;
  final double price;
  final double? originalPrice;
  final double rating;
  final int reviewsCount;
  final String description;

  const ProductInfo({
    super.key,
    required this.title,
    required this.price,
    this.originalPrice,
    this.rating = 4.8,
    this.reviewsCount = 124,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E293B),
            height: 1.3,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(Icons.star_rounded, size: 20, color: Color(0xFFF59E0B)),
            const SizedBox(width: 4),
            Text(
              rating.toStringAsFixed(1),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              '($reviewsCount reviews)',
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '\$${price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Color(0xFF2563EB),
              ),
            ),
            if (originalPrice != null && originalPrice! > price) ...[
              const SizedBox(width: 8),
              Text(
                '\$${originalPrice!.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 15,
                  decoration: TextDecoration.lineThrough,
                  color: Color(0xFF94A3B8),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          description,
          style: const TextStyle(
            fontSize: 14,
            height: 1.5,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }
}