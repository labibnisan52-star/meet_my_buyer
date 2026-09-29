import 'package:meet_my_app_buyer/models/product_card_model.dart';

class WishlistItemModel {
  final String productName;
  final String category; // "Laptop", "Mobile", "Tablet", "Audio"
  final String brand;
  final double price;
  final int moq; // Minimum Order Quantity
  final int discountPercent;
  final String? imgUrl;
  final bool isFavorite;

  WishlistItemModel({
    required this.productName,
    required this.category,
    required this.brand,
    required this.price,
    required this.moq,
    required this.discountPercent,
    this.imgUrl,
    this.isFavorite = true,
  });

  // ── ProductCardM widget-e pass korar jonno conversion ──────────────────
  // originalPrice: discountPercent theke reverse calculate kora hoyeche
  ProductCardModel toProductCardModel() {
    final original = discountPercent > 0
        ? price / (1 - (discountPercent / 100))
        : price;

    return ProductCardModel(
      company: brand,
      name: productName,
      currentPrice: price,
      originalPrice: original,
      MOQ: moq.toDouble(),
      imageUrl: imgUrl ?? '',
      discountPercent: discountPercent,
      specs: {'Category': category},
    );
  }
}
