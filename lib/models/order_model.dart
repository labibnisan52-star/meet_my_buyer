class OrderModel {
  final String orderNumber; 
  final String status; 
  final String supplierName;
  final String productName;
  final int quantity;
  final double price;
  final String? imgUrl;

  OrderModel({
    required this.orderNumber,
    required this.status,
    required this.supplierName,
    required this.productName,
    required this.quantity,
    required this.price,
    this.imgUrl,
  });
}