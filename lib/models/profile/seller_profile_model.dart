class SellerProfileModel {
  final dynamic id;
  final String companyName;
  final String initials;
  final String businessType;
  final double rating;
  final String memberSince;
  final String address;
  final bool isOnline;
  final String? profileImageUrl;

  SellerProfileModel({
    required this.id,
    required this.companyName,
    required this.initials,
    required this.businessType,
    required this.rating,
    required this.memberSince,
    required this.address,
    required this.isOnline,
    this.profileImageUrl,
  });

  factory SellerProfileModel.fromJson(Map<String, dynamic> json) {
    return SellerProfileModel(
      id: json['id'],
      companyName: json['company_name'] ?? '',
      initials: json['initials'] ?? '',
      businessType: json['business_type'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      memberSince: json['member_since'] ?? '',
      address: json['address'] ?? '',
      isOnline: json['is_online'] ?? false,
      profileImageUrl: json['profile_image_url'],
    );
  }
}
