class RfqModel {
  final String rfqId; // "RFQ-0051"
  final String productName;
  final int quantity;
  final double targetPrice;
  final String expiresIn; // "Expires in 2 days"
  final int quoteCount;
  final String status; // "Pending", "Quoted", "Closed"
  final double? bestQuotePrice;
  final String? bestQuoteSupplier;
  final bool isVerifiedSupplier;
  final String? imgUrl;

  RfqModel({
    required this.rfqId,
    required this.productName,
    required this.quantity,
    required this.targetPrice,
    required this.expiresIn,
    required this.quoteCount,
    required this.status,
    this.bestQuotePrice,
    this.bestQuoteSupplier,
    this.isVerifiedSupplier = false,
    this.imgUrl,
  });
}
