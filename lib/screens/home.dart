import 'package:flutter/material.dart';
import 'package:meet_my_app_buyer/common/appBar/primary_appBar.dart';
import 'package:meet_my_app_buyer/common/promo_slider.dart';
import 'package:meet_my_app_buyer/data/cart_dummy_data.dart';
import 'package:meet_my_app_buyer/screens/categories_screen.dart';
import 'package:meet_my_app_buyer/widgets/Product/Product_card.dart';
import 'package:meet_my_app_buyer/data/categories_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 0 = Products, 1 = Manufacturer, 2 = Wholeseller
  int _selectedTab = 0;



  // ---------------- DUMMY DATA: MANUFACTURERS ----------------
  final List<Map<String, String>> manufacturers = [
    {
      'name': 'TechCorp Bd',
      'location': 'Dhaka, Bangladesh',
      'years': '8 yrs',
      'products': '120+ Products',
      'logo': 'assets/icons/electronics.png',
    },
    {
      'name': 'Mobile Hub Manufacturing',
      'location': 'Rajshahi, Bangladesh',
      'years': '5 yrs',
      'products': '80+ Products',
      'logo': 'assets/icons/fashion.png',
    },
    {
      'name': 'GadgetPro Industries',
      'location': 'Chattogram, Bangladesh',
      'years': '10 yrs',
      'products': '200+ Products',
      'logo': 'assets/icons/home.png',
    },
  ];

  // ---------------- DUMMY DATA: WHOLESALERS ----------------
  final List<Map<String, String>> wholesalers = [
    {
      'name': 'DealHub Bd',
      'location': 'Dhaka, Bangladesh',
      'moq': 'MOQ: 50 pcs',
      'rating': '4.8',
      'logo': 'assets/icons/beauty.png',
    },
    {
      'name': 'Apple Store Bd',
      'location': 'Rajshahi, Bangladesh',
      'moq': 'MOQ: 20 pcs',
      'rating': '4.9',
      'logo': 'assets/icons/sneakers.jpg',
    },
    {
      'name': 'HP Store',
      'location': 'Khulna, Bangladesh',
      'moq': 'MOQ: 30 pcs',
      'rating': '4.6',
      'logo': 'assets/icons/electronics.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ---------- HEADER: AppBar + TabBar + SearchBar + Categories ----------
            HeaderContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Primary_AppBar(textColor: Color(0xFF111827)),
                  CustomTabBar(
                    selectedIndex: _selectedTab,
                    onTabChanged: (index) {
                      setState(() => _selectedTab = index);
                    },
                  ),
                  const SizedBox(height: 8),
                  SearchBar(),
                  const SizedBox(height: 8),
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Circular_Container(),
                ],
              ),
            ),

            const SizedBox(height: 4),

            // ---------- PROMO SLIDER ----------
            Padding(padding: const EdgeInsets.all(4), child: PromoSlider()),

            // ---------- TAB CONTENT (Products / Manufacturer / Wholeseller) — shobar niche ----------
            _buildTabContent(),
          ],
        ),
      ),
    );
  }

  // Tab index onujayi shothik content dekhabe
  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 1:
        return _buildManufacturerList();
      case 2:
        return _buildWholesalerList();
      case 0:
      default:
        return _buildProductsGrid();
    }
  }

  // ---------------- PRODUCTS TAB ----------------
  Widget _buildProductsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            "Recommended For You",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
          itemCount: dummyProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.62,
          ),
          itemBuilder: (context, index) =>
              ProductCardM(product: dummyProducts[index]),
        ),
      ],
    );
  }

  // ---------------- MANUFACTURER TAB ----------------
  Widget _buildManufacturerList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            "Verified Manufacturers",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: manufacturers.length,
          itemBuilder: (context, index) {
            final m = manufacturers[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage(m['logo']!),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                m['name']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.verified,
                              color: Colors.blue,
                              size: 16,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          m['location']!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${m['years']}  •  ${m['products']}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // ---------------- WHOLESALER TAB ----------------
  Widget _buildWholesalerList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            "Top Wholesalers",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: wholesalers.length,
          itemBuilder: (context, index) {
            final w = wholesalers[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage(w['logo']!),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          w['name']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          w['location']!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          w['moq']!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFFD700),
                        size: 16,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        w['rating']!,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

// ==================== CATEGORIES (Circular) ====================
class Circular_Container extends StatelessWidget {
  const Circular_Container({super.key});

  @override
  Widget build(BuildContext context) {
    final displayCategories = allCategories
        .where((c) => !['For you', 'Featured', 'Deals'].contains(c))
        .toList();

    return SizedBox(
      height: 146,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: displayCategories.length,
        itemBuilder: (context, index) {
          final category = displayCategories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CategoriesScreen(initialCategory: category),
                ),
              );
            },
            child: Container(
              width: 96,
              margin: const EdgeInsets.only(right: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      getCategoryEmoji(category),
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ==================== SEARCH BAR ====================
class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search in Our Marketplace',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== HEADER (AppBar background) ====================
class HeaderContainer extends StatelessWidget {
  const HeaderContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: Color(0xFFFFD700),
      ),
      child: child,
    );
  }
}

// ==================== TABS (functional) ====================
class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  Widget _buildTab(String title, int index) {
    final isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: () => onTabChanged(index),
      child: Container(
        margin: const EdgeInsets.only(right: 32),
        padding: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          border: Border(
            bottom: isSelected
                ? const BorderSide(color: Colors.black, width: 2.5)
                : BorderSide.none,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTab('Products', 0),
        _buildTab('Manufacturer', 1),
        _buildTab('Wholeseller', 2),
      ],
    );
  }
}
