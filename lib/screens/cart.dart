// lib/screens/cart/cart_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meet_my_app_buyer/screens/checkout.dart';
import 'package:meet_my_app_buyer/widgets/cart/apply_qupon_card.dart';
import 'package:meet_my_app_buyer/widgets/cart/order_summary_card.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/cart/supplier_group_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // AppBar
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFC107),
        title: const Text(
          'My Cart',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.edit, color: Colors.black, size: 16),
            label: const Text('Manage', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),

      // Body - CartProvider theke data neya hocche
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          final cartSuppliers = cart.suppliers;

          // Cart khali hole
          if (cartSuppliers.isEmpty) {
            return const Center(
              child: Text(
                'Cart is empty',
                style: TextStyle(fontSize: 16, color: Colors.black45),
              ),
            );
          }

          // Grand total ber kora (shudu selected item)
          double grandTotal = 0;
          int totalSelectedItems = 0;
          for (var supplier in cartSuppliers) {
            for (var item in supplier.items) {
              if (item.isSelected) {
                grandTotal += item.subtotal;
                totalSelectedItems += item.quantity;
              }
            }
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartSuppliers.length,
                        itemBuilder: (context, index) => SupplierGroupCard(
                          supplier: cartSuppliers[index],
                          onChanged: () => cart.refresh(),
                        ),
                      ),
                      const CouponRow(),
                      OrderSummaryCard(
                        totalUnits: totalSelectedItems,
                        subtotal: grandTotal,
                        couponDiscount: 0,
                      ),
                    ],
                  ),
                ),
              ),
              _buildBottomBar(context, totalSelectedItems, grandTotal),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBottomBar(
    BuildContext context,
    int totalSelectedItems,
    double grandTotal,
  ) {
    return Container(
      padding: const EdgeInsets.only(right: 16, top: 12, bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Total price
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$totalSelectedItems items selected'),
              Text(
                'Tk ${grandTotal.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Proceed button
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Checkout();
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFC107),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            icon: const Text(
              'Proceed to Order',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            label: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
