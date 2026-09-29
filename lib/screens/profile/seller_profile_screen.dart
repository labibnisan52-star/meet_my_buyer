import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:meet_my_app_buyer/models/profile/seller_profile_model.dart';
import 'package:meet_my_app_buyer/models/product_card_model.dart';
import 'package:meet_my_app_buyer/widgets/Product/Product_card.dart';

class SellerProfileScreen extends StatefulWidget {
  final dynamic sellerId;

  const SellerProfileScreen({super.key, required this.sellerId});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  SellerProfileModel? _seller;
  List<ProductCardModel> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final supabase = Supabase.instance.client;

      final sellerData = await supabase
          .from('sellers')
          .select()
          .eq('id', widget.sellerId)
          .single();

      final seller = SellerProfileModel.fromJson(sellerData);

      final productsData = await supabase
          .from('products')
          .select()
          .eq('seller_id', widget.sellerId);

      final products = (productsData as List).map((json) {
        return ProductCardModel(
          company: seller.companyName,
          name: json['name'] ?? 'Unknown Product',
          currentPrice: (json['current_price'] as num?)?.toDouble() ?? 0.0,
          originalPrice: (json['original_price'] as num?)?.toDouble() ?? 0.0,
          MOQ: (json['moq'] as num?)?.toDouble() ?? 1.0,
          imageUrl: json['image_url'] ?? '',
          discountPercent: (json['discount_percent'] as num?)?.toInt() ?? 0,
          specs: {},
        );
      }).toList();

      setState(() {
        _seller = seller;
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFD700)),
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text('Error: $_errorMessage')),
      );
    }

    if (_seller == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Not Found')),
        body: const Center(child: Text('Seller not found.')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(_seller!.companyName),
        backgroundColor: const Color(0xFFFFD700),
        foregroundColor: Colors.black,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildProfileHeader(_seller!),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 0.7, // Adjust to match product card aspect ratio
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ProductCardM(product: _products[index]);
                },
                childCount: _products.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(SellerProfileModel seller) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: const Color(0xFFFFD700).withOpacity(0.2),
            backgroundImage: seller.profileImageUrl != null
                ? NetworkImage(seller.profileImageUrl!)
                : null,
            child: seller.profileImageUrl == null
                ? Text(
                    seller.initials,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFD700),
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                seller.companyName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (seller.isOnline) ...[
                const SizedBox(width: 8),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(
            seller.businessType,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatInfo(Icons.star, seller.rating.toString(), 'Rating'),
              _buildStatInfo(Icons.calendar_today, seller.memberSince, 'Member Since'),
              _buildStatInfo(Icons.location_on, seller.address, 'Location'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatInfo(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFFFFD700), size: 28),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
