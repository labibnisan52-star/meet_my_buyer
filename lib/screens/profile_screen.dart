import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:meet_my_app_buyer/card/profile_header_card.dart';
import 'package:meet_my_app_buyer/common/appBar/primary_appBar.dart';
import 'package:meet_my_app_buyer/models/profile/profile_model.dart';
import 'package:meet_my_app_buyer/widgets/profile/cuopon_tab.dart';
import 'package:meet_my_app_buyer/widgets/profile/order_tab.dart';
import 'package:meet_my_app_buyer/widgets/profile/post_tab.dart';
import 'package:meet_my_app_buyer/widgets/profile/profile_tab_bar.dart';
import 'package:meet_my_app_buyer/widgets/profile/rfq_tab.dart';
import 'package:meet_my_app_buyer/widgets/profile/wishlist_tab.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedTabIndex = 0; // 0 = Post, 1 = Orders
  
  bool _isLoading = true;
  String? _errorMessage;
  ProfileModel? _profile;

  // Hardcode a buyer ID for now, e.g., 1
  final dynamic _buyerId = 1;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    try {
      final supabase = Supabase.instance.client;
      final data = await supabase
          .from('buyers')
          .select()
          .eq('id', _buyerId)
          .single();

      setState(() {
        _profile = ProfileModel.fromJson(data);
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
      return Scaffold(
        appBar: Primary_AppBar(textColor: Colors.black),
        body: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFD700)),
          ),
        ),
      );
    }

    if (_errorMessage != null || _profile == null) {
      return Scaffold(
        appBar: Primary_AppBar(textColor: Colors.black),
        body: Center(
          child: Text('Error: ${_errorMessage ?? 'Profile not found'}'),
        ),
      );
    }

    return Scaffold(
      appBar: Primary_AppBar(textColor: Colors.black),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeaderCard(user: _profile!),
            const SizedBox(height: 16),
            ProfileTabBar(
              selectedIndex: selectedTabIndex,
              onTabSelected: (index) {
                setState(() {
                  selectedTabIndex = index;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildTabContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTabIndex) {
      case 0:
        return const PostTab();
      case 1:
        return const OrderTab();
      case 2:
        return const RfqTab();
      case 3:
        return const WishlistTab();
      case 4:
        return const CouponTab();

      default:
        return const PostTab();
    }
  }
}
