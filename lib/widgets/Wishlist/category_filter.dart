import 'package:flutter/material.dart';

class WishlistFilterChips extends StatelessWidget {
  const WishlistFilterChips({
    super.key,
    required this.selectedIndex,
    required this.onFilterSelected,
  });

  final int selectedIndex;
  final Function(int) onFilterSelected;

  @override
  Widget build(BuildContext context) {
    final categories = ["All", "Laptops", "Mobiles", "Tablets", "Audio"];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(categories.length, (index) {
          final bool isSelected = index == selectedIndex;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(categories[index]),
              selected: isSelected,
              selectedColor: Colors.orange,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontSize: 12,
              ),
              backgroundColor: Colors.grey.shade200,
              onSelected: (_) => onFilterSelected(index),
            ),
          );
        }),
      ),
    );
  }
}