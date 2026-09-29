import 'cart_item_model.dart';

class CartSupplier {
  final String id;
  final String name; // "Dell Technologies BD"
  final String avatarText; // "DT"
  final bool isVerified;
  bool isSelected;
  final List<CartItem> items;

  CartSupplier({
    required this.id,
    required this.name,
    required this.avatarText,
    required this.isVerified,
    this.isSelected = true,
    required this.items,
  });

  // Supplier এর সব item এর total
  double get supplierTotal {
    double total = 0;
    for (var item in items) {
      total = total + item.subtotal;
    }
    return total;
  }

  // Supplier এর সব item select/deselect
  void toggleAll(bool value) {
    isSelected = value;
    for (var item in items) {
      item.isSelected = value;
    }
  }
}
