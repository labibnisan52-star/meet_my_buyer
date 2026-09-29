import 'package:flutter/material.dart';

class OrderFilterChips extends StatefulWidget {
  const OrderFilterChips({super.key});

  @override
  State<OrderFilterChips> createState() => _OrderFilterChipsState();
}

class _OrderFilterChipsState extends State<OrderFilterChips> {
  int selectedIndex = 0;
  final List<String> filters = ["All", "Processing", "Shipped", "Delivered", "Cancelled"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(filters.length, (index) {
          final bool isSelected = index == selectedIndex;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(filters[index]),
              selected: isSelected,
              selectedColor: Colors.orange,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontSize: 12,
              ),
              backgroundColor: Colors.grey.shade200,
              onSelected: (_) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          );
        }),
      ),
    );
  }
}