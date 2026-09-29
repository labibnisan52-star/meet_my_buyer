import 'package:flutter/material.dart';
import 'package:meet_my_app_buyer/data/dummy_data.dart';
import 'package:meet_my_app_buyer/widgets/order/filter_chips.dart';
import 'package:meet_my_app_buyer/widgets/order/order_card.dart';
import 'package:meet_my_app_buyer/widgets/order/stats_bar.dart';
// jekhane dummyOrders ache

class OrderTab extends StatelessWidget {
  const OrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OrderStatsBar(),
        const SizedBox(height: 16),
        const OrderFilterChips(),
        const SizedBox(height: 16),
        ...dummyOrders.map((order) => OrderCard(order: order)),
      ],
    );
  }
}
