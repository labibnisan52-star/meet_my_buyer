import 'package:flutter/material.dart';

class RfqHeader extends StatelessWidget {
  const RfqHeader({super.key, required this.onNewRfqTap});

  final VoidCallback onNewRfqTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "My RFQs",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        ElevatedButton.icon(
          onPressed: onNewRfqTap,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          icon: const Icon(Icons.add, size: 16, color: Colors.white),
          label: const Text("New RFQ", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}