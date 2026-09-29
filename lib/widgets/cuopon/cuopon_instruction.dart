import 'package:flutter/material.dart';

class CouponInstructions extends StatelessWidget {
  const CouponInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      "Add items to cart",
      "Go to checkout",
      "Apply coupon code",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "How to use coupons",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 12),
        ...List.generate(steps.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.orange,
                  child: Text(
                    "${index + 1}",
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
                Text(steps[index], style: const TextStyle(fontSize: 13)),
              ],
            ),
          );
        }),
      ],
    );
  }
}