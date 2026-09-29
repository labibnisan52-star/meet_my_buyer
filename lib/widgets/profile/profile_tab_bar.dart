import 'package:flutter/material.dart';

class ProfileTabBar extends StatelessWidget {
  const ProfileTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  final int selectedIndex;
  final Function(int) onTabSelected;

  final List<String> tabs = const [
    "Post",
    "Orders",
    "RFQs",
    "Wishlist",
    "Coupons",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(tabs.length, (index) {
          final bool isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () => onTabSelected(index),
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              padding: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? Colors.orange : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  color: isSelected ? Colors.orange : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
