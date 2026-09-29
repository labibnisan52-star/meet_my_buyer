import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';
import '../models/cart_supplier_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartSupplier> _suppliers = [];

  List<CartSupplier> get suppliers => _suppliers;

  // Product Details theke call hobe
  void addToCart({
    required CartItem item,
    required String supplierId,
    required String supplierName,
    required String avatarText,
    bool isVerified = false,
  }) {
    // 1. Ei supplier age theke cart e ache kina check
    final supplierIndex = _suppliers.indexWhere((s) => s.id == supplierId);

    if (supplierIndex != -1) {
      // Supplier already ache -> tar items list e item khoja
      final supplier = _suppliers[supplierIndex];
      final itemIndex = supplier.items.indexWhere((i) => i.id == item.id);

      if (itemIndex != -1) {
        // Item age theke ache -> quantity barao
        supplier.items[itemIndex].quantity += item.quantity;
      } else {
        // Notun item, existing supplier er nichey add
        supplier.items.add(item);
      }
    } else {
      // Notun supplier group toiri koro ei item diye
      _suppliers.add(
        CartSupplier(
          id: supplierId,
          name: supplierName,
          avatarText: avatarText,
          isVerified: isVerified,
          items: [item],
        ),
      );
    }

    notifyListeners();
  }

  // Cart theke ekta item remove
  void removeItem(String supplierId, String itemId) {
    final supplierIndex = _suppliers.indexWhere((s) => s.id == supplierId);
    if (supplierIndex == -1) return;

    _suppliers[supplierIndex].items.removeWhere((i) => i.id == itemId);

    // Supplier er kono item na thakle, supplier group ta o remove
    if (_suppliers[supplierIndex].items.isEmpty) {
      _suppliers.removeAt(supplierIndex);
    }

    notifyListeners();
  }

  // Selection ba quantity change korle UI update korar jonno
  void refresh() {
    notifyListeners();
  }

  int get totalItemCount {
    int count = 0;
    for (var s in _suppliers) {
      for (var i in s.items) {
        count += i.quantity;
      }
    }
    return count;
  }
}