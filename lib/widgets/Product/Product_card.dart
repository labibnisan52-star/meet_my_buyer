import 'package:flutter/material.dart';
import 'package:meet_my_app_buyer/models/product_card_model.dart';
import 'package:meet_my_app_buyer/screens/product_detail_screen.dart';

class ProductCardM extends StatefulWidget {
  final ProductCardModel product;
  const ProductCardM({super.key, required this.product});

  @override
  State<ProductCardM> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCardM> {
  bool _isWishlisted = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: widget.product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(children: [_buildImageSection(), _buildInfoSection()]),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Container(
            width: double.infinity,
            color: const Color(0xFFE8E8E8),
            child: AspectRatio(
              aspectRatio: 1.2,
              child: Image.network(
                widget.product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) =>
                    const Icon(Icons.image, size: 60, color: Colors.grey),
              ),
            ),
          ),
        ),

        Positioned(
          top: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE8A020),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '${widget.product.discountPercent}% OFF',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () => setState(() => _isWishlisted = !_isWishlisted),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Icon(
                _isWishlisted ? Icons.favorite : Icons.favorite_border,
                size: 18,
                color: _isWishlisted ? Colors.red : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand
          Text(
            widget.product.company.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),

          // Product name
          Text(
            widget.product.name,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),

          // "Starting from" label
          const Text(
            'Starting from',
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
          const SizedBox(height: 2),

          // Price row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '\$${widget.product.currentPrice.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '\$${widget.product.originalPrice.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // MOQ
          Text(
            'MOQ: ${widget.product.MOQ} Pieces',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          //const SizedBox(height: 14),

          // ADD button
          // SizedBox(
          //   width: double.infinity,
          //   child: OutlinedButton(
          //     onPressed: () {
          //       ScaffoldMessenger.of(
          //         context,
          //       ).showSnackBar(const SnackBar(content: Text('Added to cart!')));
          //     },
          //     style: OutlinedButton.styleFrom(
          //       foregroundColor: const Color(0xFFE8A020),
          //       side: const BorderSide(color: Color(0xFFE8A020), width: 1.5),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       padding: const EdgeInsets.symmetric(vertical: 12),
          //     ),
          //     child: const Text(
          //       'ADD +',
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         letterSpacing: 1.2,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
