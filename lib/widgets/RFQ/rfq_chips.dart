import 'package:flutter/material.dart';

class RfqFilterChips extends StatelessWidget {
  const RfqFilterChips({
    super.key,
    required this.selectedIndex,
    required this.onFilterSelected,
  });

  final int selectedIndex;
  final Function(int) onFilterSelected;

  @override
  Widget build(BuildContext context) {
    final filters = [
      {"label": "All", "count": null},
      {"label": "Pending", "count": 5},
      {"label": "Quoted", "count": 3},
      {"label": "Closed", "count": 2},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(filters.length, (index) {
          final bool isSelected = index == selectedIndex;
          final label = filters[index]["label"] as String;
          final count = filters[index]["count"];

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(count != null ? "$label $count" : label),
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