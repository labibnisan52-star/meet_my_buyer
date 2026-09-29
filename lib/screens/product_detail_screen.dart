import 'package:flutter/material.dart';
import 'package:meet_my_app_buyer/models/wishlist_model.dart';
import 'package:meet_my_app_buyer/screens/cart.dart';
import 'package:meet_my_app_buyer/screens/product_botton_sheet.dart';
import 'package:provider/provider.dart';
import 'package:meet_my_app_buyer/models/product_card_model.dart';
import 'package:meet_my_app_buyer/models/cart_item_model.dart';
import 'package:meet_my_app_buyer/models/variation_model.dart';

import 'package:meet_my_app_buyer/providers/cart_provider.dart';
import 'package:meet_my_app_buyer/providers/wishlist_provider.dart';
import 'package:meet_my_app_buyer/screens/profile/seller_profile_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductCardModel product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _currentImageIndex = 0;

  // product-e ekta e imageUrl ache, tai list-e shudu oitai rakhlam
  List<String> get _images => [widget.product.imageUrl];

  // ── Bottom sheet open kore variation + qty select korano ────────────────
  void _openBottomSheet({required bool isBuyNow}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ProductBottomSheet(
        product: widget.product,
        onAddToCart: (result) {
          Navigator.pop(context); // sheet close
          _addProductToCart(result);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cart e added hoyeche!')),
          );
        },
        onConfirmOrder: (result) {
          Navigator.pop(context); // sheet close
          _addProductToCart(result);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CartScreen()),
          );
        },
      ),
    );
  }

  // ── selected variations theke readable string, cart-e dekhabe ──────────
  String _variantString(Map<String, VariationOption> selectedOptions) {
    return selectedOptions.entries
        .map((e) => '${e.key}: ${e.value.label}')
        .join(', ');
  }

  // ── productId + selected variations mile ekta unique cart id ───────────
  // (jate same product-er diff variation cart-e alada item hoy)
  String _productId(ProductSelectionResult result) {
    final variantKey = result.selectedOptions.values
        .map((opt) => opt.label)
        .join('_');
    final base = '${result.product.company}_${result.product.name}';
    final full = variantKey.isEmpty ? base : '${base}_$variantKey';
    return full.replaceAll(' ', '_');
  }

  // ── Cart-e add korar logic (bottom sheet-er result theke) ───────────────
  void _addProductToCart(ProductSelectionResult result) {
    final cartItem = CartItem(
      id: _productId(result),
      name: result.product.name,
      category: result.product.company,
      imageUrl: result.product.imageUrl,
      variant: _variantString(result.selectedOptions),
      pricePerUnit: result.pricePerUnit,
      bulkPrice: result.pricePerUnit,
      bulkMinQty: result.product.MOQ.toInt(),
      quantity: result.qty.toInt(),
    );

    context.read<CartProvider>().addToCart(
      item: cartItem,
      supplierId: result.product.company,
      supplierName: result.product.company,
      avatarText: _initialsFromName(result.product.company),
      isVerified: true,
    );
  }

  String _initialsFromName(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
      return parts[0].substring(0, 1).toUpperCase();
    }
    return '?';
  }

  // ── ProductCardModel theke WishlistItemModel banano ────────────────────
  WishlistItemModel _toWishlistItem() {
    final discount = widget.product.originalPrice > 0
        ? (((widget.product.originalPrice - widget.product.currentPrice) /
                      widget.product.originalPrice) *
                  100)
              .round()
        : 0;

    return WishlistItemModel(
      productName: widget.product.name,
      category: widget.product.specs['Category'] ?? 'General',
      brand: widget.product.company,
      price: widget.product.currentPrice,
      moq: widget.product.MOQ.toInt(),
      discountPercent: discount,
      imgUrl: widget.product.imageUrl,
    );
  }

  // ── wishlist toggle kora (heart icon tap korle call hobe) ──────────────
  void _toggleWishlist() {
    final wishlistProvider = context.read<WishlistProvider>();
    final item = _toWishlistItem();
    final wasInWishlist = wishlistProvider.isInWishlist(
      item.productName,
      item.brand,
    );

    wishlistProvider.toggleWishlist(item);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          wasInWishlist
              ? 'Wishlist theke remove hoyeche'
              : 'Wishlist e added hoyeche!',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ProductAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Image Carousel
                  ProductImageCarousel(
                    images: _images,
                    currentIndex: _currentImageIndex,
                    onPageChanged: (i) =>
                        setState(() => _currentImageIndex = i),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 14),

                        // 2. Product Title (dynamic)
                        ProductTitleSection(title: widget.product.name),

                        const SizedBox(height: 6),

                        // Brand/company (product model theke)
                        Text(
                          widget.product.company.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            letterSpacing: 1.1,
                          ),
                        ),

                        const SizedBox(height: 14),

                        // 3. Wholesale Pricing (currentPrice/originalPrice/MOQ dynamic,
                        // tier price gula static rekhe dilam - model e tier data nai)
                        WholesalePricingSection(
                          samplePrice:
                              '\$${widget.product.currentPrice.toStringAsFixed(0)}',
                          minimumOrder: '${widget.product.MOQ} pairs',
                          onGetSample: () {},
                          tiers: [
                            PriceTier(
                              label: '${widget.product.MOQ} - 49 pairs',
                              price:
                                  '\$${widget.product.originalPrice.toStringAsFixed(0)}',
                            ),
                            PriceTier(
                              label: '50 - 99 pairs',
                              price:
                                  '\$${widget.product.currentPrice.toStringAsFixed(0)}',
                              bestValue: true,
                            ),
                            const PriceTier(
                              label: '100+ pairs',
                              price: '\$145.00',
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // NOTE: Age ekhane inline VariationSelector +
                        // QuantitySelector chilo. Shegula bottom sheet e
                        // move kora hoyeche (Add to Cart / Buy Now tap
                        // korle open hoy), tai duplicate UI rakha hoy nai.
                        // Jodi user product page-e already ki ki
                        // variation available seta preview hisebe dekhte
                        // chao (select na kore), tahole "Available options"
                        // hisebe shudu chip/label dekhate paro — select
                        // korar joggo noy.

                        // 8. Supplier Card
                        SupplierCard(
                          name: widget.product.company,
                          subtitle: 'Verified Product Supplier',
                          responseRate: '99%',
                          onTimeDelivery: '98%',
                          profileImageUrl: widget.product.supplierImageUrl,
                          onTap: () {
                            // If sellerId is present, navigate to SellerProfileScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SellerProfileScreen(
                                  sellerId: widget.product.sellerId ?? 
                                    widget.product.company, // Fallback to company name if no ID
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 16),

                        // 9. Specifications (static - model e specs nai)
                        SpecificationsSection(specs: widget.product.specs),

                        const SizedBox(height: 16),
                        const CustomerReviewsSection(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 10. Bottom Action Bar — ekhon bottom sheet open kore + wishlist workable
          BottomActionBar(
            onAddToCartTap: () => _openBottomSheet(isBuyNow: false),
            onBuyNowTap: () => _openBottomSheet(isBuyNow: true),
            onWishlistTap: _toggleWishlist,
            isWishlisted: context.watch<WishlistProvider>().isInWishlist(
              widget.product.name,
              widget.product.company,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── 1. APP BAR ───────────────────────────────────────────────────────────────

class ProductAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProductAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: const Color(0xFFFFC107),
      elevation: 0,
      leadingWidth: 16,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Color(0xFF6D5100),
          size: 20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Product Details',
        style: TextStyle(
          color: Color(0xFF6D5100),
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.share_outlined, color: Color(0xFF6D5100)),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            Icons.shopping_cart_outlined,
            color: Color(0xFF6D5100),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

// ─── 2. IMAGE CAROUSEL ────────────────────────────────────────────────────────

class ProductImageCarousel extends StatelessWidget {
  const ProductImageCarousel({
    super.key,
    required this.images,
    required this.currentIndex,
    required this.onPageChanged,
  });

  final List<String> images;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 420,
          child: PageView.builder(
            itemCount: images.length,
            onPageChanged: onPageChanged,
            itemBuilder: (_, i) => Image.network(
              images[i],
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                color: Colors.grey.shade200,
                child: const Icon(Icons.image, size: 60, color: Colors.grey),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              images.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: i == currentIndex ? 16 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: i == currentIndex
                      ? const Color(0xFFFFC107)
                      : const Color(0xFFE2E2E2),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── 3. PRODUCT TITLE ────────────────────────────────────────────────────────

class ProductTitleSection extends StatelessWidget {
  final String title;
  const ProductTitleSection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: Colors.black87,
      ),
    );
  }
}

// ─── 4. WHOLESALE PRICING ────────────────────────────────────────────────────

class PriceTier {
  final String label;
  final String price;
  final bool bestValue;
  const PriceTier({
    required this.label,
    required this.price,
    this.bestValue = false,
  });
}

class WholesalePricingSection extends StatelessWidget {
  final List<PriceTier> tiers;
  final String samplePrice;
  final String minimumOrder;
  final VoidCallback onGetSample;

  const WholesalePricingSection({
    super.key,
    required this.tiers,
    required this.samplePrice,
    required this.minimumOrder,
    required this.onGetSample,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'WHOLESALE PRICING',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: tiers
                .map((tier) => Expanded(child: _PriceTierCell(tier: tier)))
                .toList(),
          ),
          const Divider(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black87, fontSize: 14),
                  children: [
                    const TextSpan(text: 'Sample price: '),
                    TextSpan(
                      text: samplePrice,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: onGetSample,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 0,
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text('Get sample'),
              ),
            ],
          ),
          const Divider(height: 28),
          Row(
            children: [
              const Icon(Icons.info_outline, size: 14, color: Colors.black38),
              const SizedBox(width: 4),
              Text(
                'Minimum order: $minimumOrder',
                style: const TextStyle(fontSize: 12, color: Colors.black45),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PriceTierCell extends StatelessWidget {
  final PriceTier tier;
  const _PriceTierCell({required this.tier});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: tier.bestValue
          ? BoxDecoration(
              border: Border.all(color: const Color(0xFFFFD600), width: 1.5),
              borderRadius: BorderRadius.circular(6),
            )
          : null,
      child: Column(
        children: [
          Text(
            tier.price,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            tier.label,
            style: const TextStyle(fontSize: 11, color: Colors.black45),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ─── 9. SUPPLIER CARD ────────────────────────────────────────────────────────

class SupplierCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String responseRate;
  final String onTimeDelivery;
  final String? profileImageUrl;
  final VoidCallback? onTap;

  const SupplierCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.responseRate,
    required this.onTimeDelivery,
    this.profileImageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF8F9FA),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(6),
                  image: profileImageUrl != null
                      ? DecorationImage(
                          image: NetworkImage(profileImageUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: profileImageUrl == null
                    ? const Icon(
                        Icons.store_outlined,
                        size: 20,
                        color: Colors.black54,
                      )
                    : null,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.verified,
                          size: 14,
                          color: Color(0xFFFFD600),
                        ),
                      ],
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _SupplierStat(label: 'RESPONSE RATE', value: responseRate),
              const SizedBox(width: 32),
              _SupplierStat(label: 'ON-TIME DELIVERY', value: onTimeDelivery),
            ],
          ),
        ],
      ),
      ),
    );
  }
}

class _SupplierStat extends StatelessWidget {
  final String label;
  final String value;
  const _SupplierStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.black38,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

// ─── 10. SPECIFICATIONS ──────────────────────────────────────────────────────

class SpecificationsSection extends StatelessWidget {
  final Map<String, String> specs;
  const SpecificationsSection({super.key, required this.specs});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Specifications',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              Icon(Icons.open_in_full, size: 14, color: Colors.grey.shade400),
            ],
          ),
          const SizedBox(height: 12),
          ...specs.entries.map((e) => _SpecRow(label: e.key, value: e.value)),
        ],
      ),
    );
  }
}

class _SpecRow extends StatelessWidget {
  final String label;
  final String value;
  const _SpecRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Colors.black45),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── CUSTOMER REVIEWS ─────────────────────────────────────────────────────────

class CustomerReviewsSection extends StatelessWidget {
  const CustomerReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Customer Reviews',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Text(
                        '4.8',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF6D5100),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.star,
                        color: Color(0xFF6D5100),
                        size: 18,
                      ),
                    ],
                  ),
                  const Text(
                    '124 reviews',
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.person_outline_rounded,
                        color: Colors.black45,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Retail Partner A.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              const Text(
                                '2 days ago',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: List.generate(
                              5,
                              (index) => const Icon(
                                Icons.star,
                                color: Color(0xFF6D5100),
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Great quality and fast shipping. Our customers love these.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── 11. BOTTOM ACTION BAR ───────────────────────────────────────────────────
// NOTUN: onWishlistTap + isWishlisted param add kora hoyeche.
// Heart icon ekhon dynamic — wishlist-e thakle filled red heart dekhabe,
// na thakle outline heart dekhabe.

class BottomActionBar extends StatelessWidget {
  final VoidCallback onAddToCartTap;
  final VoidCallback onBuyNowTap;
  final VoidCallback onWishlistTap;
  final bool isWishlisted;

  const BottomActionBar({
    super.key,
    required this.onAddToCartTap,
    required this.onBuyNowTap,
    required this.onWishlistTap,
    required this.isWishlisted,
  });

  @override
  Widget build(BuildContext context) {
    // Screen choto hole (jemon 360px er niche) icon button gula hide kore dibo,
    // shudhu wishlist + Add to Cart + Buy Now rakhbo
    final screenWidth = MediaQuery.of(context).size.width;
    final isNarrow = screenWidth < 360;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Choto screen-e ei duita icon hide kore dibo, jaiga bachate
            if (!isNarrow) ...[
              _CompactIconButton(icon: Icons.store_outlined, onTap: () {}),
              _CompactIconButton(
                icon: Icons.chat_bubble_outline_rounded,
                onTap: () {},
              ),
            ],
            _CompactIconButton(
              icon: isWishlisted
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              iconColor: isWishlisted ? const Color(0xFFD32F2F) : null,
              onTap: onWishlistTap,
            ),
            const SizedBox(width: 6),
            Expanded(
              flex: 2,
              child: OutlinedButton(
                onPressed: onAddToCartTap,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF6D5100),
                  side: const BorderSide(color: Color(0xFF6D5100), width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  minimumSize: const Size(0, 44), // <-- tap area protect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const FittedBox(
                  fit: BoxFit
                      .scaleDown, // <-- text choto screen-e nijei shrink hobe
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 3,
              child: ElevatedButton(
                onPressed: onBuyNowTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD600),
                  foregroundColor: Colors.black,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  minimumSize: const Size(0, 44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Buy Now',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Choto, tight icon button — default IconButton-er 48x48 minimum size
// remove kore dilam, jate mobile-e beshi jaiga na khay
class _CompactIconButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final VoidCallback onTap;

  const _CompactIconButton({
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: iconColor ?? const Color(0xFF4F4632), size: 22),
      onPressed: onTap,
      padding: const EdgeInsets.all(6),
      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
      splashRadius: 20,
    );
  }
}
