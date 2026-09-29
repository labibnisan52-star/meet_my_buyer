import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meet_my_app_buyer/models/product_card_model.dart';
import 'package:meet_my_app_buyer/models/variation_model.dart';

// ---------------------------------------------------------------------------
// FINAL VERSION - tomar age-r code base dhore, ekta bug fix kora hoyeche +
// kichu chotto polish. Baki shob logic tomar original design onujayi.
//
// FIX: currentTier-er orElse "first" theke "last" kora hoyeche.
//   Karon: jodi quantity shobcheye boro tier-er range o pero jay
//   (jemon tier list-e "50+ pcs" upper bound thake na, kintu tumi
//   MOQ/stock onujayi arektu boro quantity dile), matches() shob tier-e
//   fail korte pare. Tokhon "first" dile shobcheye kom-quantity/beshi-price
//   wala tier dekhabe (ULTA result). "last" dile shobcheye boro-quantity
//   wala tier (shadharonoto sob theke kom price) dekhabe, ja actual
//   business logic-er sathe match kore.
//
// HOW TO OPEN (product details page-e Buy Now / Add to Cart button-e):
//
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (_) => ProductBottomSheet(
//       product: myProductCardModel,
//       onAddToCart: (result) { ... },
//       onConfirmOrder: (result) { ... },
//     ),
//   );
// ---------------------------------------------------------------------------

class ProductSelectionResult {
  final ProductCardModel product;
  final Map<String, VariationOption>
  selectedOptions; // group name -> chosen option
  final double qty;
  final double pricePerUnit;
  final double total;

  ProductSelectionResult({
    required this.product,
    required this.selectedOptions,
    required this.qty,
    required this.pricePerUnit,
    required this.total,
  });
}

class ProductBottomSheet extends StatefulWidget {
  final ProductCardModel product;
  final ValueChanged<ProductSelectionResult>? onAddToCart;
  final ValueChanged<ProductSelectionResult>? onConfirmOrder;

  const ProductBottomSheet({
    super.key,
    required this.product,
    this.onAddToCart,
    this.onConfirmOrder,
  });

  @override
  State<ProductBottomSheet> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ProductBottomSheet> {
  static const Color orange = Color(0xFFF5821F);
  static const Color orangeLight = Color(0xFFFFF3E5);
  static const Color orangeBorder = Color(0xFFF3D9A8);

  late double qty;
  final Map<String, VariationOption> selected = {};

  ProductCardModel get product => widget.product;

  @override
  void initState() {
    super.initState();
    qty = product.MOQ;
    for (final group in product.variations) {
      if (group.options.isNotEmpty) {
        // out-of-stock na hoile prothom option default select
        selected[group.name] = group.options.firstWhere(
          (o) => o.stock > 0,
          orElse: () => group.options.first,
        );
      }
    }
  }

  // ---- price tier logic --------------------------------------------------

  bool get hasTiers => product.priceTiers.isNotEmpty;

  PriceTier? get currentTier {
    if (!hasTiers) return null;
    return product.priceTiers.firstWhere(
      (t) => t.matches(qty),
      orElse: () => product.priceTiers.last, // FIX: first -> last
    );
  }

  double get basePrice => currentTier?.price ?? product.currentPrice;

  double get variationDelta =>
      selected.values.fold(0.0, (sum, opt) => sum + (opt.priceDelta ?? 0));

  double get pricePerUnit => basePrice + variationDelta;

  double get total => pricePerUnit * qty;

  double get saved {
    if (hasTiers) {
      final base = product.priceTiers.first.price;
      final diff = (base - basePrice) * qty;
      return diff > 0 ? diff : 0;
    }
    final diff = (product.originalPrice - product.currentPrice) * qty;
    return diff > 0 ? diff : 0;
  }

  // ---- stock: min stock among currently selected options ------------------

  double get effectiveStock {
    if (selected.isEmpty) return double.infinity;
    final stocks = selected.values.map((o) => o.stock).where((s) => s > 0);
    if (stocks.isEmpty) return double.infinity;
    return stocks.reduce((a, b) => a < b ? a : b).toDouble();
  }

  String fmt(num n) => NumberFormat.decimalPattern('en_IN').format(n);

  void changeQty(double delta) {
    setState(() {
      final maxQty = effectiveStock;
      qty = (qty + delta).clamp(
        product.MOQ,
        maxQty.isFinite ? maxQty : double.infinity,
      );
    });
  }

  ProductSelectionResult _buildResult() => ProductSelectionResult(
    product: product,
    selectedOptions: Map.from(selected),
    qty: qty,
    pricePerUnit: pricePerUnit,
    total: total,
  );

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 18),
                    _buildPriceBanner(),
                    if (product.variations.isNotEmpty)
                      for (final group in product.variations) ...[
                        const SizedBox(height: 20),
                        _buildVariationSection(group),
                      ],
                    const SizedBox(height: 20),
                    _buildQuantitySection(),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              _buildFooter(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: product.imageUrl.isNotEmpty
              ? Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                    size: 22,
                  ),
                )
              : const Icon(
                  Icons.inventory_2_outlined,
                  color: Colors.grey,
                  size: 24,
                ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      product.company,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.verified, size: 13, color: Colors.green),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close, size: 16, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceBanner() {
    final showRibbon = product.discountPercent > 0;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.only(top: showRibbon ? 14 : 0),
          decoration: BoxDecoration(
            color: orangeLight,
            border: Border.all(color: orangeBorder),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showRibbon) const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
                child: hasTiers ? _buildTierRow() : _buildSimplePrice(),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: orangeBorder)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.local_shipping_outlined,
                      size: 13,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'FOB Dhaka · Lead time: 7-10 days',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (showRibbon)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFE53935),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Text(
              'LOWER PRICED THAN SIMILAR',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTierRow() {
    return Row(
      children: List.generate(product.priceTiers.length, (i) {
        final tier = product.priceTiers[i];
        final isActive = tier == currentTier;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(left: i == 0 ? 0 : 4),
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: isActive
                      ? orange
                      : (i == 0 ? Colors.transparent : orangeBorder),
                  width: isActive ? 3 : 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\u09F3${fmt(tier.price)}',
                  style: TextStyle(
                    fontSize: isActive ? 17 : 15,
                    fontWeight: isActive ? FontWeight.w800 : FontWeight.w700,
                    color: isActive ? orange : Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  tier.label,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSimplePrice() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '\u09F3${fmt(product.currentPrice)}',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: orange,
          ),
        ),
        if (product.originalPrice > product.currentPrice) ...[
          const SizedBox(width: 8),
          Text(
            '\u09F3${fmt(product.originalPrice)}',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade500,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildVariationSection(VariationGroup group) {
    final selectedOption = selected[group.name];
    if (group.isColorType) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                group.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Selected: ${selectedOption?.label ?? "-"}',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 14,
            runSpacing: 10,
            children: group.options.map((opt) {
              final isSelected = opt.label == selectedOption?.label;
              final outOfStock = opt.stock <= 0;
              return GestureDetector(
                onTap: outOfStock
                    ? null
                    : () => setState(() => selected[group.name] = opt),
                child: Opacity(
                  opacity: outOfStock ? 0.35 : 1,
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: orange, width: 2)
                          : null,
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: opt.colorValue ?? Colors.grey.shade300,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                        ),
                        if (isSelected)
                          Positioned(
                            bottom: -2,
                            right: -2,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: orange,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),
                              child: const Icon(
                                Icons.check,
                                size: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          group.name,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: group.options.map((opt) {
            final isSelected = opt.label == selectedOption?.label;
            final outOfStock = opt.stock <= 0;
            final double delta = opt.priceDelta ?? 0;
            final String deltaLabel = delta == 0
                ? ''
                : ' (${delta > 0 ? '+' : ''}\u09F3${fmt(delta)})';
            return GestureDetector(
              onTap: outOfStock
                  ? null
                  : () => setState(() => selected[group.name] = opt),
              child: Opacity(
                opacity: outOfStock ? 0.35 : 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 14,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? orange : Colors.white,
                    border: Border.all(
                      color: isSelected ? orange : Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    opt.label + deltaLabel,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildQuantitySection() {
    final stockLabel = effectiveStock.isFinite
        ? '${fmt(effectiveStock)} units'
        : 'In stock';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Quantity',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              'Stock: $stockLabel',
              style: const TextStyle(fontSize: 12, color: Colors.green),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _qtyButton(
                  icon: Icons.remove,
                  onTap: qty > product.MOQ ? () => changeQty(-1) : null,
                  filled: false,
                ),
                SizedBox(
                  width: 48,
                  child: Text(
                    qty == qty.roundToDouble()
                        ? qty.toInt().toString()
                        : qty.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _qtyButton(
                  icon: Icons.add,
                  onTap: qty < effectiveStock ? () => changeQty(1) : null,
                  filled: true,
                ),
              ],
            ),
            Text(
              'Minimum order: ${product.MOQ.toInt()} units',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ],
        ),
      ],
    );
  }

  Widget _qtyButton({
    required IconData icon,
    required VoidCallback? onTap,
    required bool filled,
  }) {
    final disabled = onTap == null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: filled
              ? (disabled ? Colors.grey.shade300 : orange)
              : Colors.white,
          border: filled ? null : Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 16,
          color: filled
              ? Colors.white
              : (disabled ? Colors.grey.shade400 : Colors.grey.shade700),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        12 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\u09F3${fmt(total)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                if (saved > 0)
                  Text(
                    '\u09F3${fmt(saved)} saved \u{1F389}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton(
            onPressed: () => widget.onAddToCart?.call(_buildResult()),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey.shade300),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Add to Cart',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => widget.onConfirmOrder?.call(_buildResult()),
            style: ElevatedButton.styleFrom(
              backgroundColor: orange,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Confirm Order',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward, color: Colors.white, size: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
