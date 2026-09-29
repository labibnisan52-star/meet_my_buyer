import 'package:flutter/material.dart';
import 'package:meet_my_app_buyer/models/wishlist_model.dart';
import 'package:provider/provider.dart';

import 'package:meet_my_app_buyer/widgets/product/product_card.dart';
import 'package:meet_my_app_buyer/providers/wishlist_provider.dart';

// ─── WISHLIST TAB ─────────────────────────────────────────────────────────
// CHANGE LOG:
// 1. dummyWishlist (static data) sorano hoyeche — ekhon WishlistProvider
//    theke real, dynamic wishlist data ashe.
// 2. Category filter chips ekhon actually filter kore (age shudu UI-te
//    selected dekhato, kono filtering hoto na).
// 3. Wishlist khali thakle empty state dekhano hoy.
// 4. WishlistItemModel -> ProductCardModel convert kore ProductCardM-e
//    pass kora hoy (toProductCardModel() method diye).

class WishlistTab extends StatefulWidget {
  const WishlistTab({super.key});

  @override
  State<WishlistTab> createState() => _WishlistTabState();
}

class _WishlistTabState extends State<WishlistTab> {
  int selectedFilterIndex = 0;

  final List<String> categories = [
    "All",
    "Laptops",
    "Mobiles",
    "Tablets",
    "Audio",
  ];

  // ── selected category onujayi wishlist items filter kora ───────────────
  List<WishlistItemModel> _filteredItems(List<WishlistItemModel> allItems) {
    if (selectedFilterIndex == 0) return allItems; // "All"

    final selectedCategory = categories[selectedFilterIndex];
    return allItems
        .where(
          (item) =>
              item.category.toLowerCase() ==
              selectedCategory.toLowerCase().replaceAll(
                RegExp(r's$'),
                '',
              ), // "Laptops" -> "Laptop" match korar jonno
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final wishlistItems = context.watch<WishlistProvider>().items;
    final filteredItems = _filteredItems(wishlistItems);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Filter chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(categories.length, (index) {
              final bool isSelected = index == selectedFilterIndex;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(categories[index]),
                  selected: isSelected,
                  selectedColor: const Color(0xFFE8A020),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontSize: 12,
                  ),
                  backgroundColor: Colors.grey.shade200,
                  onSelected: (_) {
                    setState(() {
                      selectedFilterIndex = index;
                    });
                  },
                ),
              );
            }),
          ),
        ),

        const SizedBox(height: 16),

        // Wishlist khali thakle empty state
        if (filteredItems.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.favorite_border_rounded,
                    size: 48,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    wishlistItems.isEmpty
                        ? 'Wishlist is empty'
                        : 'No item in this Categorey',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          )
        else
          // Product grid — real wishlist data theke
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.62,
            ),
            itemBuilder: (context, index) {
              return ProductCardM(
                product: filteredItems[index].toProductCardModel(),
              );
            },
          ),
      ],
    );
  }
}
