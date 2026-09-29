import 'package:meet_my_app_buyer/models/variation_model.dart';

class PriceTier {
  final double minQty;
  final double maxQty; // no upper limit hole double.infinity dao
  final double price;

  const PriceTier({
    required this.minQty,
    this.maxQty = double.infinity,
    required this.price,
  });

  bool matches(double qty) => qty >= minQty && qty <= maxQty;

  String get label => maxQty.isInfinite
      ? '${minQty.toInt()}+ pcs'
      : '${minQty.toInt()}-${maxQty.toInt()} pcs';
}

class ProductCardModel {
  final String company;
  final String name;
  final double currentPrice;
  final double originalPrice;
  final double MOQ;
  final String imageUrl;
  final int discountPercent;
  final Map<String, String> specs;
  final List<VariationGroup> variations;
  final String? sellerId;
  final String? supplierImageUrl;
  final List<PriceTier> priceTiers;

  const ProductCardModel({
    this.sellerId,
    this.supplierImageUrl,
    required this.company,
    required this.name,
    required this.currentPrice,
    required this.MOQ,
    required this.imageUrl,
    required this.discountPercent,
    required this.originalPrice,
    required this.specs,
    this.variations = const [],
    this.priceTiers = const [],
  });
}
