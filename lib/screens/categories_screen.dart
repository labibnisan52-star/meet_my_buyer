import 'package:flutter/material.dart';
import 'package:meet_my_app_buyer/models/product_card_model.dart';
import 'package:meet_my_app_buyer/widgets/Product/Product_card.dart';
import 'package:meet_my_app_buyer/data/categories_data.dart';

class CategoriesScreen extends StatefulWidget {
  final String? initialCategory; // <-- notun parameter

  const CategoriesScreen({super.key, this.initialCategory});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

// Small wrapper so we can tag each product with a brand without
// touching your existing ProductCardModel class.
class _BrandedProduct {
  final String brand;
  final ProductCardModel product;
  const _BrandedProduct(this.brand, this.product);
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _selectedCategory = 0;
  String _selectedBrand = 'All';

  @override
  void initState() {
    super.initState();
    // jodi kono initialCategory pass kora hoy, tahole
    // shurutei shei category select kore rakhbe
    if (widget.initialCategory != null) {
      final index = allCategories.indexOf(widget.initialCategory!);
      if (index != -1) {
        _selectedCategory = index;
      }
    }
  }

  static const Color kGold = Color(0xFFB8860B);
  static const Color kSidebarBg = Color(0xFFF3F3F3);

  // Dummy products grouped by category, each tagged with its brand.
  // Replace this whole map with your real data source (API/DB).
  final Map<String, List<_BrandedProduct>> _productsByCategory = {
    'For you': [
      _BrandedProduct(
        'Dell',
        const ProductCardModel(
          company: 'TechCorp Bd',
          name: 'Dell Inspiron 15',
          currentPrice: 52000,
          originalPrice: 65000,
          MOQ: 5,
          imageUrl: 'https://via.placeholder.com/300',
          discountPercent: 20,
          specs: {},
        ),
      ),
      _BrandedProduct(
        'Samsung',
        const ProductCardModel(
          company: 'Mobile Hub',
          name: 'Samsung Galaxy A55',
          currentPrice: 26000,
          originalPrice: 31500,
          MOQ: 10,
          imageUrl: 'https://via.placeholder.com/300',
          discountPercent: 18,
          specs: {},
        ),
      ),
    ],
    'Featured': [
      _BrandedProduct(
        'JBL',
        const ProductCardModel(
          company: 'GadgetPro',
          name: 'JBL Flip 6 Speaker',
          currentPrice: 8500,
          originalPrice: 11000,
          MOQ: 20,
          imageUrl: 'https://via.placeholder.com/300',
          discountPercent: 22,
          specs: {},
        ),
      ),
    ],
    'Deals': [
      _BrandedProduct(
        'Xiaomi',
        const ProductCardModel(
          company: 'DealHub Bd',
          name: 'Xiaomi Redmi Note 13',
          currentPrice: 19000,
          originalPrice: 24000,
          MOQ: 15,
          imageUrl: 'https://via.placeholder.com/300',
          discountPercent: 21,
          specs: {},
        ),
      ),
    ],
    'Computer Parts & Accessories': [
      _BrandedProduct(
        'Dell',
        const ProductCardModel(
          company: 'TechCorp Bd',
          name: 'Dell Inspiron 15',
          currentPrice: 52000,
          originalPrice: 65000,
          MOQ: 5,
          imageUrl: 'https://via.placeholder.com/300',
          discountPercent: 20,
          specs: {},
        ),
      ),
      _BrandedProduct(
        'HP',
        const ProductCardModel(
          company: 'HP Store',
          name: 'HP Pavilion 14',
          currentPrice: 58000,
          originalPrice: 68000,
          MOQ: 5,
          imageUrl: 'https://via.placeholder.com/300',
          discountPercent: 15,
          specs: {},
        ),
      ),
      _BrandedProduct(
        'Lenovo',
        const ProductCardModel(
          company: 'Lenovo Bd',
          name: 'Lenovo IdeaPad Slim 3',
          currentPrice: 49000,
          originalPrice: 56000,
          MOQ: 5,
          imageUrl: 'https://via.placeholder.com/300',
          discountPercent: 12,
          specs: {},
        ),
      ),
      _BrandedProduct(
        'Asus',
        const ProductCardModel(
          company: 'Asus Store',
          name: 'Asus Vivobook 15',
          currentPrice: 54000,
          originalPrice: 61000,
          MOQ: 5,
          imageUrl: 'https://via.placeholder.com/300',
          discountPercent: 11,
          specs: {},
        ),
      ),
      _BrandedProduct(
        'Apple',
        const ProductCardModel(
          company: 'Apple Store Bd',
          name: 'MacBook Air M2',
          currentPrice: 128000,
          originalPrice: 142000,
          MOQ: 2,
          imageUrl: 'https://via.placeholder.com/300',
          discountPercent: 10,
          specs: {},
        ),
      ),
    ],
    'Mobile Gadgets & Accessories': [
      _BrandedProduct(
        'Samsung',
        const ProductCardModel(
          company: 'Mobile Hub',
          name: 'Samsung Galaxy A55',
          currentPrice: 26000,
          originalPrice: 31500,
          MOQ: 10,
          imageUrl: 'https://via.placeholder.com/300',
          discountPercent: 18,
          specs: {},
        ),
      ),
      _BrandedProduct(
        'Apple',
        const ProductCardModel(
          company: 'Mobile Hub',
          name: 'iPhone 13',
          currentPrice: 68000,
          originalPrice: 78000,
          MOQ: 5,
          imageUrl: 'https://via.placeholder.com/300',
          discountPercent: 13,
          specs: {},
        ),
      ),
      _BrandedProduct(
        'Xiaomi',
        const ProductCardModel(
          company: 'DealHub Bd',
          name: 'Redmi Note 13',
          currentPrice: 19000,
          originalPrice: 24000,
          MOQ: 15,
          imageUrl: 'https://via.placeholder.com/300',
          discountPercent: 21,
          specs: {},
        ),
      ),
      _BrandedProduct(
        'Realme',
        const ProductCardModel(
          company: 'Mobile Hub',
          name: 'Realme 12 Pro',
          currentPrice: 27000,
          originalPrice: 32000,
          MOQ: 10,
          imageUrl: 'https://via.placeholder.com/300',
          discountPercent: 16,
          specs: {},
        ),
      ),
      _BrandedProduct(
        'Vivo',
        const ProductCardModel(
          company: 'Mobile Hub',
          name: 'Vivo V29',
          currentPrice: 34000,
          originalPrice: 39000,
          MOQ: 10,
          imageUrl: 'https://via.placeholder.com/300',
          discountPercent: 13,
          specs: {},
        ),
      ),
    ],
    'Electrical & Electronics': [
      _BrandedProduct(
        'Sony',
        const ProductCardModel(
          company: 'GadgetPro',
          name: 'Sony WH-1000XM5',
          currentPrice: 32000,
          originalPrice: 39000,
          MOQ: 10,
          imageUrl: 'https://via.placeholder.com/300',
          discountPercent: 18,
          specs: {},
        ),
      ),
      _BrandedProduct(
        'JBL',
        const ProductCardModel(
          company: 'GadgetPro',
          name: 'JBL Flip 6 Speaker',
          currentPrice: 8500,
          originalPrice: 11000,
          MOQ: 20,
          imageUrl: 'https://via.placeholder.com/300',
          discountPercent: 22,
          specs: {},
        ),
      ),
      _BrandedProduct(
        'Boat',
        const ProductCardModel(
          company: 'GadgetPro',
          name: 'Boat Rockerz 450',
          currentPrice: 2800,
          originalPrice: 3500,
          MOQ: 30,
          imageUrl: 'https://via.placeholder.com/300',
          discountPercent: 20,
          specs: {},
        ),
      ),
    ],
    'Mobile Parts & Display': [
      _BrandedProduct(
        'Apple',
        const ProductCardModel(
          company: 'Apple Store Bd',
          name: 'iPad 10th Gen',
          currentPrice: 45000,
          originalPrice: 52000,
          MOQ: 5,
          imageUrl: 'https://via.placeholder.com/300',
          discountPercent: 13,
          specs: {},
        ),
      ),
      _BrandedProduct(
        'Samsung',
        const ProductCardModel(
          company: 'Mobile Hub',
          name: 'Galaxy Tab S9',
          currentPrice: 62000,
          originalPrice: 71000,
          MOQ: 5,
          imageUrl: 'https://via.placeholder.com/300',
          discountPercent: 13,
          specs: {},
        ),
      ),
    ],
    'Women\'s Fashion': [
      _BrandedProduct('Generic', const ProductCardModel(company: 'Fashion Hub', name: 'Women\'s Kurti', currentPrice: 1200, originalPrice: 1500, MOQ: 10, imageUrl: 'https://via.placeholder.com/300', discountPercent: 20, specs: {})),
    ],
    'Men\'s Fashion': [
      _BrandedProduct('Generic', const ProductCardModel(company: 'Men\'s Style', name: 'Casual Shirt', currentPrice: 800, originalPrice: 1000, MOQ: 20, imageUrl: 'https://via.placeholder.com/300', discountPercent: 20, specs: {})),
    ],
    'Footwear': [
      _BrandedProduct('Bata', const ProductCardModel(company: 'Bata Bd', name: 'Formal Shoes', currentPrice: 2500, originalPrice: 3000, MOQ: 5, imageUrl: 'https://via.placeholder.com/300', discountPercent: 15, specs: {})),
    ],
    'Bags & Luggage': [
      _BrandedProduct('Samsonite', const ProductCardModel(company: 'Bag Center', name: 'Travel Trolley', currentPrice: 4500, originalPrice: 5500, MOQ: 2, imageUrl: 'https://via.placeholder.com/300', discountPercent: 18, specs: {})),
    ],
    'Jewelry': [
      _BrandedProduct('Generic', const ProductCardModel(company: 'Gold Smith', name: 'Gold Plated Necklace', currentPrice: 3000, originalPrice: 4000, MOQ: 5, imageUrl: 'https://via.placeholder.com/300', discountPercent: 25, specs: {})),
    ],
    'Toys': [
      _BrandedProduct('Lego', const ProductCardModel(company: 'Toy Kingdom', name: 'Building Blocks', currentPrice: 1500, originalPrice: 1800, MOQ: 10, imageUrl: 'https://via.placeholder.com/300', discountPercent: 16, specs: {})),
    ],
    'Footwear Accessories': [
      _BrandedProduct('Generic', const ProductCardModel(company: 'Shoe Care', name: 'Shoe Polish & Brush', currentPrice: 200, originalPrice: 250, MOQ: 50, imageUrl: 'https://via.placeholder.com/300', discountPercent: 20, specs: {})),
    ],
    'Fabrics & Garment Accessories': [
      _BrandedProduct('Generic', const ProductCardModel(company: 'Textile Hub', name: 'Cotton Fabric Roll', currentPrice: 12000, originalPrice: 15000, MOQ: 1, imageUrl: 'https://via.placeholder.com/300', discountPercent: 20, specs: {})),
    ],
    'Leather & Accessories': [
      _BrandedProduct('Apex', const ProductCardModel(company: 'Leather World', name: 'Leather Belt', currentPrice: 600, originalPrice: 800, MOQ: 20, imageUrl: 'https://via.placeholder.com/300', discountPercent: 25, specs: {})),
    ],
    'Machinery & Parts': [
      _BrandedProduct('Generic', const ProductCardModel(company: 'Machinery Corp', name: 'Industrial Motor', currentPrice: 45000, originalPrice: 50000, MOQ: 1, imageUrl: 'https://via.placeholder.com/300', discountPercent: 10, specs: {})),
    ],
    'Tools & Hardware': [
      _BrandedProduct('Bosch', const ProductCardModel(company: 'Hardware Plus', name: 'Power Drill', currentPrice: 5500, originalPrice: 6500, MOQ: 5, imageUrl: 'https://via.placeholder.com/300', discountPercent: 15, specs: {})),
    ],
    'Packaging & Printing': [
      _BrandedProduct('Generic', const ProductCardModel(company: 'Pack Bd', name: 'Corrugated Boxes', currentPrice: 50, originalPrice: 60, MOQ: 1000, imageUrl: 'https://via.placeholder.com/300', discountPercent: 16, specs: {})),
    ],
    'Furniture': [
      _BrandedProduct('Hatil', const ProductCardModel(company: 'Hatil Furnitures', name: 'Office Chair', currentPrice: 8500, originalPrice: 10000, MOQ: 2, imageUrl: 'https://via.placeholder.com/300', discountPercent: 15, specs: {})),
    ],
    'Chemicals': [
      _BrandedProduct('Generic', const ProductCardModel(company: 'Chem Corp', name: 'Industrial Solvent', currentPrice: 2500, originalPrice: 3000, MOQ: 20, imageUrl: 'https://via.placeholder.com/300', discountPercent: 16, specs: {})),
    ],
    'Motorcycle Parts & Accessories': [
      _BrandedProduct('Yamaha', const ProductCardModel(company: 'Bike Parts Bd', name: 'Engine Oil', currentPrice: 600, originalPrice: 700, MOQ: 20, imageUrl: 'https://via.placeholder.com/300', discountPercent: 14, specs: {})),
    ],
    'Car Parts & Accessories': [
      _BrandedProduct('Toyota', const ProductCardModel(company: 'Auto Parts Bd', name: 'Brake Pads', currentPrice: 3500, originalPrice: 4000, MOQ: 10, imageUrl: 'https://via.placeholder.com/300', discountPercent: 12, specs: {})),
    ],
    'Agriculture & Food': [
      _BrandedProduct('Generic', const ProductCardModel(company: 'Agri Hub', name: 'Fertilizer Pack', currentPrice: 1200, originalPrice: 1400, MOQ: 50, imageUrl: 'https://via.placeholder.com/300', discountPercent: 14, specs: {})),
    ],
    'Health Accessories': [
      _BrandedProduct('Generic', const ProductCardModel(company: 'MediCare Bd', name: 'Digital BP Machine', currentPrice: 2200, originalPrice: 2800, MOQ: 10, imageUrl: 'https://via.placeholder.com/300', discountPercent: 21, specs: {})),
    ],
    'Sports Accessories': [
      _BrandedProduct('Nike', const ProductCardModel(company: 'Sports Zone', name: 'Football', currentPrice: 1500, originalPrice: 2000, MOQ: 15, imageUrl: 'https://via.placeholder.com/300', discountPercent: 25, specs: {})),
    ],
    'Services': [
      _BrandedProduct('Generic', const ProductCardModel(company: 'Service Hub', name: 'Consultancy Service', currentPrice: 5000, originalPrice: 6000, MOQ: 1, imageUrl: 'https://via.placeholder.com/300', discountPercent: 16, specs: {})),
    ],
  };

  String get _currentCategoryKey => allCategories[_selectedCategory];

  List<_BrandedProduct> get _productsInCategory =>
      _productsByCategory[_currentCategoryKey] ?? [];

  List<String> get _brandsInCategory {
    final brands = _productsInCategory.map((p) => p.brand).toSet().toList();
    brands.sort();
    return ['All', ...brands];
  }

  List<ProductCardModel> get _filteredProducts {
    final products = _productsInCategory;
    if (_selectedBrand == 'All') return products.map((p) => p.product).toList();
    return products
        .where((p) => p.brand == _selectedBrand)
        .map((p) => p.product)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD700),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Categories',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.help_outline, color: Colors.black87),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSidebar(),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  // ---------------- SIDEBAR ----------------
  Widget _buildSidebar() {
    return Container(
      width: 92,
      color: kSidebarBg,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8),
        itemCount: allCategories.length,
        itemBuilder: (context, index) {
          final isSelected = index == _selectedCategory;
          return GestureDetector(
            onTap: () => setState(() {
              _selectedCategory = index;
              _selectedBrand = 'All'; // reset brand filter on category change
            }),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                border: Border(
                  left: BorderSide(
                    color: isSelected ? kGold : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 3D Image Placeholder
                  // Replace this with your actual 3D image assets (e.g. Image.asset('assets/3d/...'))
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      getCategoryEmoji(allCategories[index]),
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    allCategories[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      color: isSelected ? Colors.black87 : Colors.grey[600],
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------- RIGHT CONTENT ----------------
  Widget _buildContent() {
    // "For you" keeps the original banner + recommendations layout.
    // Every other category shows: brand row -> filtered product grid.
    final isForYou = _selectedCategory == 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isForYou) ...[
            _buildLocalStockBanner(),
            const SizedBox(height: 20),
            const Text(
              'Recommendations',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            _buildRecommendationsGrid(),
            const SizedBox(height: 20),
          ],
          _buildCategoryTitle(),
          const SizedBox(height: 12),
          if (_brandsInCategory.length > 1) ...[
            _buildBrandRow(),
            const SizedBox(height: 16),
          ],
          _buildProductGrid(),
        ],
      ),
    );
  }

  Widget _buildLocalStockBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF1B4B4B), Color(0xFF2E9E7F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'LOCAL STOCK',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                _bannerBullet('Fastest delivery in 3–5 days'),
                const SizedBox(height: 4),
                _bannerBullet('No import charges'),
              ],
            ),
          ),
          const Icon(Icons.local_shipping, color: Colors.white, size: 40),
        ],
      ),
    );
  }

  Widget _bannerBullet(String text) {
    return Row(
      children: [
        const Icon(Icons.check_circle, color: Colors.white, size: 14),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _buildRecommendationsGrid() {
    final items = [
      _RecommendationItem(
        label: 'Hot selling',
        icon: Icons.whatshot,
        bg: const Color(0xFFE8A020),
      ),
      _RecommendationItem(
        label: 'Laptops',
        icon: Icons.laptop_mac,
        bg: Colors.white,
        hasBorder: true,
      ),
      _RecommendationItem(
        label: 'Mobiles',
        icon: Icons.phone_iphone,
        bg: Colors.white,
        hasBorder: true,
      ),
      _RecommendationItem(
        label: 'Server Racks',
        icon: Icons.dns,
        bg: const Color(0xFF1A1A2E),
        iconColor: Colors.white,
      ),
    ];

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 0.85,
      children: items.map((item) => _buildRecommendationTile(item)).toList(),
    );
  }

  Widget _buildRecommendationTile(_RecommendationItem item) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: item.bg,
                borderRadius: BorderRadius.circular(14),
                border: item.hasBorder
                    ? Border.all(color: Colors.grey.shade300)
                    : null,
              ),
              child: Icon(
                item.icon,
                color:
                    item.iconColor ??
                    (item.bg == Colors.white ? Colors.black54 : Colors.white),
                size: 28,
              ),
            ),
            Positioned(
              top: -2,
              right: -2,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8A020),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          item.label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11, color: Colors.black87),
        ),
      ],
    );
  }

  // ---------------- CATEGORY TITLE ----------------
  Widget _buildCategoryTitle() {
    final title = _currentCategoryKey.replaceAll('\n', ' ');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: kGold,
            padding: EdgeInsets.zero,
          ),
          child: const Row(
            children: [
              Text(
                'View All',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              Icon(Icons.chevron_right, size: 16),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------- BRAND ROW ----------------
  Widget _buildBrandRow() {
    final brands = _brandsInCategory;
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: brands.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final brand = brands[index];
          final isSelected = brand == _selectedBrand;
          return GestureDetector(
            onTap: () => setState(() => _selectedBrand = brand),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? kGold : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? kGold : Colors.grey.shade300,
                ),
              ),
              child: Center(
                child: Text(
                  brand,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------- PRODUCT GRID ----------------
  Widget _buildProductGrid() {
    final products = _filteredProducts;

    if (products.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Center(
          child: Text(
            'No products in this category yet',
            style: TextStyle(color: Colors.grey[500], fontSize: 13),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (context, index) => ProductCardM(product: products[index]),
    );
  }
}

class _RecommendationItem {
  final String label;
  final IconData icon;
  final Color bg;
  final bool hasBorder;
  final Color? iconColor;

  _RecommendationItem({
    required this.label,
    required this.icon,
    required this.bg,
    this.hasBorder = false,
    this.iconColor,
  });
}
