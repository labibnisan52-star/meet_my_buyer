import 'package:flutter/material.dart';

class OrderStatsBar extends StatelessWidget {
  const OrderStatsBar({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = [
      {"count": 3, "label": "To Pay", "icon": Icons.receipt_long_outlined, "color": Colors.orange},
      {"count": 2, "label": "To Ship", "icon": Icons.local_shipping_outlined, "color": Colors.blue},
      {"count": 5, "label": "Received", "icon": Icons.inventory_2_outlined, "color": Colors.green},
      {"count": 8, "label": "To Review", "icon": Icons.star_border, "color": Colors.amber},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: stats.map((item) {
        return Column(
          children: [
            Icon(item["icon"] as IconData, color: item["color"] as Color),
            const SizedBox(height: 4),
            Text(
              "${item["count"]}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              item["label"] as String,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
            ),
          ],
        );
      }).toList(),
    );
  }
}