import 'package:flutter/material.dart';
import 'package:meet_my_app_buyer/models/order_model.dart';


class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});

  final OrderModel order;

  Color _statusColor(String status) {
    switch (status) {
      case "Processing":
        return Colors.orange;
      case "Shipped":
        return Colors.blue;
      case "Delivered":
        return Colors.green;
      case "Cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order number + status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order #${order.orderNumber}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.5,
                ),
              ),
              Text(
                order.status.toUpperCase(),
                style: TextStyle(
                  color: _statusColor(order.status),
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Supplier name
          Row(
            children: [
              Icon(
                Icons.storefront_outlined,
                size: 14,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 4),
              Text(
                order.supplierName,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Product row
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: order.imgUrl != null
                    ? Image.network(
                        order.imgUrl!,
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 55,
                        height: 55,
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.inventory_2_outlined,
                          color: Colors.grey.shade500,
                        ),
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Qty: ${order.quantity}",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "৳${order.price.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  fontSize: 13.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Action buttons (status অনুযায়ী বদলায়)
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    if (order.status == "Delivered") {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              child: const Text("View Details"),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () {},
              child: const Text(
                "Write Review",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      );
    }

    // Processing / Shipped
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            child: const Text("Track Order"),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () {},
            child: const Text(
              "View Details",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
