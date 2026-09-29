import 'package:flutter/material.dart';
import 'package:meet_my_app_buyer/widgets/cart/cart_item_card.dart';
import '../../models/cart_supplier_model.dart';

class SupplierGroupCard extends StatefulWidget {
  final CartSupplier supplier;
  final VoidCallback onChanged;

  const SupplierGroupCard({
    super.key,
    required this.supplier,
    required this.onChanged,
  });

  @override
  State<SupplierGroupCard> createState() => _SupplierGroupCardState();
}

class _SupplierGroupCardState extends State<SupplierGroupCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 4, bottom: 4),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Color(0xFFF8FAFC)),
            child: Row(
              children: [
                Checkbox(
                  value: widget.supplier.isSelected,
                  onChanged: (newValue) {
                    setState(() {
                      widget.supplier.toggleAll(newValue!);
                    });
                    widget.onChanged();
                  },
                ),

                CircleAvatar(
                  radius: 14,
                  child: Text(widget.supplier.avatarText),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    widget.supplier.name,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          for (var item in widget.supplier.items)
            CartItemCard(
              item: item,
              onChanged: () {
                setState(() {});
                widget.onChanged();
              },
            ),
        ],
      ),
    );
  }
}
