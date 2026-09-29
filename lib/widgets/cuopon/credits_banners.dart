import 'package:flutter/material.dart';

class CreditsBanner extends StatelessWidget {
  const CreditsBanner({
    super.key,
    required this.credits,
    required this.onRedeemTap,
  });

  final int credits;
  final VoidCallback onRedeemTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2233),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.bolt, color: Colors.orange),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$credits Credits Available",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Redeem for discount on next order",
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 11.5),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onRedeemTap,
            child: Row(
              children: const [
                Text(
                  "Redeem",
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.arrow_forward, color: Colors.orange, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
