import 'package:flutter/material.dart';

class ProductImageGallery extends StatelessWidget {
  final List<String> images;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const ProductImageGallery({
    super.key,
    required this.images,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveImages = images.isEmpty
        ? ['assets/images/placeholder.png']
        : images;

    return Column(
      children: [
        Container(
          height: 320,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: effectiveImages[selectedIndex].startsWith('http')
                ? Image.network(
                    effectiveImages[selectedIndex],
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.image_not_supported_outlined,
                      size: 48,
                      color: Color(0xFF94A3B8),
                    ),
                  )
                : Image.asset(
                    effectiveImages[selectedIndex],
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.image_not_supported_outlined,
                      size: 48,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
          ),
        ),
        if (effectiveImages.length > 1) ...[
          const SizedBox(height: 12),
          SizedBox(
            height: 64,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: effectiveImages.length,
              itemBuilder: (context, index) {
                final isSelected = index == selectedIndex;
                return GestureDetector(
                  onTap: () => onSelect(index),
                  child: Container(
                    width: 64,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF2563EB)
                            : const Color(0xFFE2E8F0),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: effectiveImages[index].startsWith('http')
                          ? Image.network(effectiveImages[index], fit: BoxFit.cover)
                          : Image.asset(effectiveImages[index], fit: BoxFit.cover),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}