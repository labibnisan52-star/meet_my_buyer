import 'package:flutter/material.dart';
import '../../models/cart_item_model.dart';

class CartItemCard extends StatefulWidget {
  final CartItem item;
  final VoidCallback onChanged;

  const CartItemCard({super.key, required this.item, required this.onChanged});

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Checkbox

              // Product Image
              Container(
                width: 80,
                height: 80,
                color: Colors.grey[200],
                child: const Icon(Icons.image),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFFFEF3C7),
                          ),
                          child: Text(
                            widget.item.category,
                            style: const TextStyle(
                              color: Color(0xFF92400E),
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.item.isSelected = !widget.item.isSelected;
                            });
                            widget.onChanged();
                          },
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.item.isSelected
                                  ? Color(0xFFFACC15)
                                  : Colors.grey.shade200,
                              border: Border.all(
                                color: widget.item.isSelected
                                    ? Color(0xFFFACC15)
                                    : Colors.grey.shade400,
                                width: 2,
                              ),
                            ),
                            child: widget.item.isSelected
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 12,
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),

                    // Name
                    Text(
                      widget.item.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),

                    //variety
                    // Text()

                    // Price per unit
                    Row(
                      children: [
                        Text(
                          'Tk ${widget.item.pricePerUnit}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '/unit',
                          style: TextStyle(color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),

                    // Bulk price
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Color(0xFFF1F5F9),
                          ),
                          child: Text(
                            '${widget.item.bulkMinQty}+ pcs = Tk${widget.item.bulkPrice}/unit',
                            style: const TextStyle(
                              color: Color(0xFF475569),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Spacer(),

                        GestureDetector(
                          onTap: () {
                            // delete logic
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.grey.shade400,
                            size: 23,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),

                    // Quantity + Subtotal
                    Row(
                      children: [
                        Container(
                          width: 98,
                          height: 28,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xFFE2E8F0),
                              width: 2,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Minus button
                              Container(
                                width: 30,
                                height: 28,
                                color: Color.fromARGB(255, 237, 242, 247),

                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  iconSize: 16,
                                  icon: const Icon(Icons.remove, size: 16),
                                  onPressed: () {
                                    setState(() {
                                      if (widget.item.quantity > 1) {
                                        widget.item.quantity--;
                                      }
                                    });
                                    widget.onChanged();
                                  },
                                  constraints: const BoxConstraints(),
                                ),
                              ),

                              // Quantity
                              Expanded(
                                child: Text(
                                  '${widget.item.quantity}',
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              // Plus button
                              Container(
                                width: 30,
                                height: 28,
                                color: Color.fromARGB(255, 246, 234, 186),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.add, size: 16),
                                  onPressed: () {
                                    setState(() {
                                      widget.item.quantity++;
                                    });
                                    widget.onChanged();
                                  },
                                  iconSize: 16,
                                  constraints: const BoxConstraints(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),

                        // Subtotal
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "SubTotal",

                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64748B),
                              ),
                            ),
                            Text(
                              'Tk ${widget.item.subtotal.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 2,
          color: Color(0xFFF8FAFC),
          margin: EdgeInsets.symmetric(vertical: 12),
        ),
      ],
    );
  }
}
