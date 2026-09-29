class ProfileModel {
  final String userName;
  final String initials;
  final String customerType;
  final int credits;
  final String activeLevel;
  final String address;
  final bool isOnline;
  final String? profileImageUrl;

  ProfileModel({
    required this.userName,
    required this.initials,
    required this.customerType,
    required this.credits,
    required this.activeLevel,
    required this.address,
    this.isOnline = true, 
    this.profileImageUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userName: json['user_name'] ?? '',
      initials: json['initials'] ?? '',
      customerType: json['customer_type'] ?? '',
      credits: (json['credits'] as num?)?.toInt() ?? 0,
      activeLevel: json['active_level'] ?? '',
      address: json['address'] ?? '',
      isOnline: json['is_online'] ?? false,
      profileImageUrl: json['profile_image_url'],
    );
  }
}