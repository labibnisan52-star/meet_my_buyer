import 'package:flutter/material.dart';
import 'package:meet_my_app_buyer/data/dummy_data.dart';
import 'package:meet_my_app_buyer/widgets/cuopon/credits_banners.dart';
import 'package:meet_my_app_buyer/widgets/cuopon/cuopon_card.dart';
import 'package:meet_my_app_buyer/widgets/cuopon/cuopon_instruction.dart';

class CouponTab extends StatefulWidget {
  const CouponTab({super.key});

  @override
  State<CouponTab> createState() => _CouponTabState();
}

class _CouponTabState extends State<CouponTab> {
  int selectedFilterIndex = 0;
  final List<String> filters = ["Available", "Used", "Expired"];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Filter chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(filters.length, (index) {
              final bool isSelected = index == selectedFilterIndex;
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
                      selectedFilterIndex = index;
                    });
                  },
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 16),

        CreditsBanner(credits: 2450, onRedeemTap: () {}),
        const SizedBox(height: 16),

        ...dummyCoupons.map((coupon) => CouponCard(coupon: coupon)),

        const SizedBox(height: 20),
        const Divider(),
        const SizedBox(height: 16),
        const CouponInstructions(),
      ],
    );
  }
}
