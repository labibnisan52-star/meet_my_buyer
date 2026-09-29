import 'package:flutter/material.dart';
import 'package:meet_my_app_buyer/models/wishlist_model.dart';

// ─── WISHLIST PROVIDER ───────────────────────────────────────────────────
// CartProvider-er moto pattern follow kora hoyeche.
// Model-e kono unique 'id' field nai, tai productName + brand combine kore
// ekta unique key banano hoyeche (duplicate check korar jonno).

class WishlistProvider extends ChangeNotifier {
  final List<WishlistItemModel> _items = [];

  List<WishlistItemModel> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  bool get isEmpty => _items.isEmpty;

  // ── unique key generator (productName + brand mile) ──────────────────
  String _keyOf(String productName, String brand) {
    return '${productName}_$brand'.replaceAll(' ', '_').toLowerCase();
  }

  // ── check kora item wishlist-e ache kina ──────────────────────────────
  bool isInWishlist(String productName, String brand) {
    final key = _keyOf(productName, brand);
    return _items.any((item) => _keyOf(item.productName, item.brand) == key);
  }

  // ── wishlist-e add kora ────────────────────────────────────────────────
  void addToWishlist(WishlistItemModel item) {
    if (!isInWishlist(item.productName, item.brand)) {
      _items.add(item);
      notifyListeners();
    }
  }

  // ── wishlist theke remove kora ─────────────────────────────────────────
  void removeFromWishlist(String productName, String brand) {
    final key = _keyOf(productName, brand);
    _items.removeWhere((item) => _keyOf(item.productName, item.brand) == key);
    notifyListeners();
  }

  // ── toggle kora (heart icon tap korle ei function call hobe) ──────────
  void toggleWishlist(WishlistItemModel item) {
    if (isInWishlist(item.productName, item.brand)) {
      removeFromWishlist(item.productName, item.brand);
    } else {
      addToWishlist(item);
    }
  }

  // ── shob clear kora (dorkar hole) ──────────────────────────────────────
  void clearWishlist() {
    _items.clear();
    notifyListeners();
  }
}
