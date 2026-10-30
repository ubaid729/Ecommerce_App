import 'package:flutter/material.dart';

class ProductOptions extends StatelessWidget {
  final List<int> colors;
  final int selectedColorIndex;
  final ValueChanged<int> onColorSelected;

  final List<String> sizes;
  final int selectedSizeIndex;
  final ValueChanged<int> onSizeSelected;

  const ProductOptions({
    super.key,
    required this.colors,
    required this.selectedColorIndex,
    required this.onColorSelected,
    required this.sizes,
    required this.selectedSizeIndex,
    required this.onSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Color',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: List.generate(colors.length, (index) {
            final isSelected = index == selectedColorIndex;
            return GestureDetector(
              onTap: () => onColorSelected(index),
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? const Color(0xFF2563EB) : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Color(colors[index]),
                  child: isSelected
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : null,
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        const Text(
          'Select Size',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: List.generate(sizes.length, (index) {
            final isSelected = index == selectedSizeIndex;
            return GestureDetector(
              onTap: () => onSizeSelected(index),
              child: Container(
                width: 44,
                height: 44,
                margin: const EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF2563EB) : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF2563EB)
                        : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Text(
                  sizes[index],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : const Color(0xFF1E293B),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}