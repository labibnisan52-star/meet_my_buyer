class CartItem {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final String variant; 
  final double pricePerUnit;
  final double bulkPrice; 
  final int bulkMinQty; 
  int quantity;
  bool isSelected;

  CartItem({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.variant,
    required this.pricePerUnit,
    required this.bulkPrice,
    required this.bulkMinQty,
    this.quantity = 1,
    this.isSelected = true,
  });

  double get effectivePrice {
    if (quantity >= bulkMinQty) {
      return bulkPrice;
    } else {
      return pricePerUnit;
    }
  }

  double get subtotal {
    return effectivePrice * quantity;
  }
}
