import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int _selectedPayment = 0;
  bool _isPlacingOrder = false;

  final List<Map<String, dynamic>> _paymentMethods = [
    {'icon': Icons.money, 'title': 'Cash on Delivery', 'sub': 'Pay in cash upon delivery'},
  ];

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    double grandTotal = 0;
    int totalItems = 0;
    for (var supplier in cart.suppliers) {
      for (var item in supplier.items) {
        if (item.isSelected) {
          grandTotal += item.subtotal;
          totalItems += item.quantity;
        }
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD400),
        elevation: 0,
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Delivery Address
                  _SectionCard(
                    title: 'Delivery Address',
                    trailing: TextButton(
                      onPressed: () {},
                      child: const Text('Change', style: TextStyle(color: Color(0xFFB8860B))),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF3D6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.location_on_outlined, color: Color(0xFFB8860B)),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Global Trade HQ',
                                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                              SizedBox(height: 2),
                              Text('42 Shaheed Nagar, Rajshahi-6000\nBangladesh',
                                  style: TextStyle(color: Colors.black54, fontSize: 13)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Order Summary
                  _SectionCard(
                    title: 'Order Summary ($totalItems items)',
                    child: Column(
                      children: [
                        for (var supplier in cart.suppliers)
                          for (var item in supplier.items)
                            if (item.isSelected)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(Icons.inventory_2_outlined,
                                          color: Colors.grey),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(item.name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600)),
                                          Text('Qty: ${item.quantity}',
                                              style: const TextStyle(
                                                  color: Colors.black45, fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'Tk ${item.subtotal.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Payment Method
                  _SectionCard(
                    title: 'Payment Method',
                    child: Column(
                      children: List.generate(_paymentMethods.length, (index) {
                        final method = _paymentMethods[index];
                        final isSelected = _selectedPayment == index;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedPayment = index),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFFFF8E1)
                                  : Colors.white,
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFFFFD700)
                                    : Colors.grey.shade200,
                                width: isSelected ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(method['icon'] as IconData,
                                    color: isSelected
                                        ? const Color(0xFFB8860B)
                                        : Colors.grey,
                                    size: 22),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(method['title'] as String,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: isSelected
                                                ? Colors.black87
                                                : Colors.black54,
                                          )),
                                      Text(method['sub'] as String,
                                          style: const TextStyle(
                                              fontSize: 12, color: Colors.black38)),
                                    ],
                                  ),
                                ),
                                Radio<int>(
                                  value: index,
                                  groupValue: _selectedPayment,
                                  onChanged: (v) => setState(() => _selectedPayment = v!),
                                  activeColor: const Color(0xFFB8860B),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Price Breakdown
                  _SectionCard(
                    title: 'Price Breakdown',
                    child: Column(
                      children: [
                        _PriceRow(label: 'Subtotal ($totalItems items)',
                            value: 'Tk ${grandTotal.toStringAsFixed(0)}'),
                        const _PriceRow(label: 'Shipping', value: 'Free'),
                        const _PriceRow(label: 'Coupon Discount', value: '— Tk 0'),
                        const Divider(height: 20),
                        _PriceRow(
                          label: 'Total',
                          value: 'Tk ${grandTotal.toStringAsFixed(0)}',
                          isBold: true,
                          valueColor: const Color(0xFFB8860B),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),

          // Place Order Button
          Container(
            padding: EdgeInsets.fromLTRB(
                16, 12, 16, 12 + MediaQuery.of(context).padding.bottom),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isPlacingOrder
                    ? null
                    : () async {
                        setState(() => _isPlacingOrder = true);
                        await Future.delayed(const Duration(seconds: 1));
                        if (context.mounted) {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              title: const Icon(Icons.check_circle_rounded,
                                  color: Colors.green, size: 56),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('Order Placed!',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center),
                                  const SizedBox(height: 8),
                                  Text(
                                      'Your order of Tk ${grandTotal.toStringAsFixed(0)} has been confirmed.',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.black54, fontSize: 14)),
                                ],
                              ),
                              actionsAlignment: MainAxisAlignment.center,
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFFFD700),
                                      foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  onPressed: () {
                                    Navigator.pop(context); // Close dialog
                                    Navigator.pop(context); // Pop checkout
                                    Navigator.pop(context); // Pop cart?
                                  },
                                  child: const Text('Back to Home'),
                                ),
                              ],
                            ),
                          );
                          setState(() => _isPlacingOrder = false);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: _isPlacingOrder
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.black))
                    : Text(
                        'Place Order · Tk ${grandTotal.toStringAsFixed(0)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;

  const _SectionCard({required this.title, required this.child, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15)),
              ?trailing,
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;

  const _PriceRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 14,
                  color: isBold ? Colors.black87 : Colors.black54,
                  fontWeight:
                      isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight:
                      isBold ? FontWeight.bold : FontWeight.w500,
                  color: valueColor ?? Colors.black87)),
        ],
      ),
    );
  }
}
