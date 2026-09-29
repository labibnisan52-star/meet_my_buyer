import 'package:flutter/material.dart';
import 'package:meet_my_app_buyer/models/rfq_model.dart';


class RfqCard extends StatelessWidget {
  const RfqCard({super.key, required this.rfq});

  final RfqModel rfq;

  Color _statusColor() {
    switch (rfq.status) {
      case "Quoted":
        return Colors.blue;
      case "Closed":
        return Colors.grey;
      default:
        return Colors.orange; // Pending
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
          // Top row: RFQ ID + status/quote badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "RFQ #${rfq.rfqId}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _statusColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  rfq.status == "Pending" ? "Pending" : "${rfq.quoteCount} Quotes",
                  style: TextStyle(
                    color: _statusColor(),
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Product row
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: rfq.imgUrl != null
                    ? Image.network(rfq.imgUrl!, width: 55, height: 55, fit: BoxFit.cover)
                    : Container(
                        width: 55,
                        height: 55,
                        color: Colors.grey.shade200,
                        child: Icon(Icons.inventory_2_outlined, color: Colors.grey.shade500),
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rfq.productName,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Qty: ${rfq.quantity} units · Target: ৳${rfq.targetPrice.toStringAsFixed(0)}/unit",
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 11.5),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 12, color: Colors.orange.shade300),
                        const SizedBox(width: 4),
                        Text(
                          rfq.expiresIn,
                          style: TextStyle(color: Colors.orange.shade300, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Best quote section (only if quote exists)
          if (rfq.bestQuotePrice != null) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 12, color: Colors.black87),
                        children: [
                          const TextSpan(text: "Best Quote: "),
                          TextSpan(
                            text: "৳${rfq.bestQuotePrice!.toStringAsFixed(0)}/unit by ${rfq.bestQuoteSupplier}",
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (rfq.isVerifiedSupplier)
                    const Icon(Icons.verified, size: 16, color: Colors.green),
                ],
              ),
            ),
          ],

          const SizedBox(height: 12),

          // Action buttons (status অনুযায়ী বদলায়)
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    if (rfq.status == "Pending") {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit_outlined, size: 14),
              label: const Text("Edit RFQ"),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              child: const Text("Close RFQ"),
            ),
          ),
        ],
      );
    }

    // Quoted
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () {},
            child: const Text("View Quotes", style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            child: const Text("Close RFQ"),
          ),
        ),
      ],
    );
  }
}
