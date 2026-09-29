class CouponModel {
  final String title;
  final String description; 
  final String code; 
  final String discountLabel; 
  final String discountSubLabel; 
  final String validityText; 
  final String status; 

  CouponModel({
    required this.title,
    required this.description,
    required this.code,
    required this.discountLabel,
    required this.discountSubLabel,
    required this.validityText,
    required this.status,
  });
}