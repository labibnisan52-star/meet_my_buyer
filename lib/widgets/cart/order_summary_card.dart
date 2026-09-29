import 'package:flutter/material.dart';

class OrderSummaryCard extends StatelessWidget {
  final int totalUnits;
  final double subtotal;
  final double couponDiscount;

  const OrderSummaryCard({
    super.key,
    required this.totalUnits,
    required this.subtotal,
    required this.couponDiscount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            "Order Summary",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          // Subtotal row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal ($totalUnits units)",
                style: TextStyle(color: Colors.grey.shade600),
              ),
              Text(
                "Tk ${subtotal.toStringAsFixed(0)}",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Shipping", style: TextStyle(color: Colors.grey.shade600)),
              Text(
                "FREE",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          // Trade Assurance row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Trade Assurance",
                style: TextStyle(color: Colors.grey.shade600),
              ),
              Text(
                "Included",
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          // Coupon Discount row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Coupon Discount",
                style: TextStyle(color: Colors.grey.shade600),
              ),
              Text(
                "- Tk ${couponDiscount.toStringAsFixed(0)}",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Divider
          Divider(color: Colors.grey.shade300),
          SizedBox(height: 12),

          // Total row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "Tk ${(subtotal - couponDiscount).toStringAsFixed(0)}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
