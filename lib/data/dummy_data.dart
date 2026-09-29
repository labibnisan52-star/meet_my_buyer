import 'package:flutter/material.dart';
import 'package:meet_my_app_buyer/models/Coupon_model.dart';
import 'package:meet_my_app_buyer/models/order_model.dart';
import 'package:meet_my_app_buyer/models/product_card_model.dart';
import 'package:meet_my_app_buyer/models/profile/post_model.dart';
import 'package:meet_my_app_buyer/models/profile/profile_model.dart';
import 'package:meet_my_app_buyer/models/rfq_model.dart';
import 'package:meet_my_app_buyer/models/variation_model.dart';

final ProfileModel dummyProfile = ProfileModel(
  userName: "Global Trade",
  initials: "GT",
  customerType: "Buyer",
  credits: 2450,
  activeLevel: "Active Level",
  address: "Rajshahi, Bangladesh",
  isOnline: true,
  profileImageUrl: null,
);

final List<PostModel> dummyPosts = [
  PostModel(
    userName: "Global Trade",
    postTime: "2 hours ago",
    postText:
        "New stock arrival! Our premium line of industrial-grade safety gear is now available for immediate dispatch.",
    imgUrl: "https://images.unsplash.com/photo-1581092160562-40aa08e78837",
    interestedCount: 0,
    isInterested: false,
  ),
  PostModel(
    userName: "Global Trade",
    postTime: "5 hours ago",
    postText:
        "Q3 inventory update: We have successfully restocked our high-capacity server racks. Available for immediate dispatch. Contact your rep for custom configurations.",
    imgUrl: null,
    interestedCount: 2,
    isInterested: false,
  ),
];

final List<OrderModel> dummyOrders = [
  OrderModel(
    orderNumber: "MMP-2048",
    status: "Processing",
    supplierName: "TechSource BD",
    productName: "Dell Inspiron 15 Core i5 13th Gen",
    quantity: 10,
    price: 520000,
  ),
  OrderModel(
    orderNumber: "MMP-2031",
    status: "Shipped",
    supplierName: "Mobile World",
    productName: "Samsung Galaxy A55",
    quantity: 20,
    price: 570000,
  ),
  OrderModel(
    orderNumber: "MMP-2019",
    status: "Delivered",
    supplierName: "AudioHub",
    productName: "Sony WH-1000XM5",
    quantity: 15,
    price: 270000,
  ),
];

final List<RfqModel> dummyRfqs = [
  RfqModel(
    rfqId: "RFQ-0051",
    productName: "Apple iPad 10th Gen x50",
    quantity: 50,
    targetPrice: 42000,
    expiresIn: "Expires in 2 days",
    quoteCount: 3,
    status: "Quoted",
    bestQuotePrice: 40500,
    bestQuoteSupplier: "Apple BD",
    isVerifiedSupplier: true,
  ),
  RfqModel(
    rfqId: "RFQ-0049",
    productName: "Dell Inspiron 15 x100",
    quantity: 100,
    targetPrice: 50000,
    expiresIn: "Expires in 5 days",
    quoteCount: 1,
    status: "Quoted",
    bestQuotePrice: 49200,
    bestQuoteSupplier: "Dell BD",
    isVerifiedSupplier: true,
  ),
  RfqModel(
    rfqId: "RFQ-0045",
    productName: "Samsung Galaxy A55 x200",
    quantity: 200,
    targetPrice: 26000,
    expiresIn: "Expires in 8 days",
    quoteCount: 0,
    status: "Pending",
  ),
];

// ekhon protita product-er jonno alada alada specs deya holo (age shobar jonno same chilo)
// ── priceTiers add kora hoyeche: MOQ theke shuru kore quantity barle price komte thake ──
final List<ProductCardModel> dummyWishlist = [
// ── Laptop example ──
ProductCardModel(
  company: 'Dell Technologies BD',
  name: 'Dell Inspiron 15 Core i5',
  currentPrice: 45000,
  originalPrice: 62000,
  MOQ: 5,
  imageUrl: 'https://example.com/laptop.png',
  discountPercent: 27,
  specs: {
    'Processor': 'Intel Core i5 12th Gen',
    'Warranty': '1 Year',
  },
  priceTiers: const [
    PriceTier(minQty: 5, maxQty: 9, price: 62000),
    PriceTier(minQty: 10, maxQty: 49, price: 52000),
    PriceTier(minQty: 50, price: 45000), // 50+ (maxQty default = infinity)
  ],
  variations: [
    VariationGroup(
      name: 'Color',
      isColorType: true,
      options: [
        VariationOption(label: 'Silver', colorValue: Colors.grey.shade300, stock: 4800),
        VariationOption(label: 'Black', colorValue: Colors.black, stock: 3000),
        VariationOption(label: 'Navy Blue', colorValue: Colors.indigo, stock: 1200),
        VariationOption(label: 'Gold', colorValue: Colors.amber, stock: 0), // out of stock
      ],
    ),
    VariationGroup(
      name: 'Storage',
      options: [
        VariationOption(label: '256GB SSD', stock: 4800),
        VariationOption(label: '512GB SSD', stock: 2200, priceDelta: 2500),
        VariationOption(label: '1TB SSD', stock: 900, priceDelta: 5500),
      ],
    ),
    VariationGroup(
      name: 'RAM',
      options: [
        VariationOption(label: '8GB', stock: 4800),
        VariationOption(label: '16GB', stock: 1800, priceDelta: 3000),
        VariationOption(label: '32GB', stock: 600, priceDelta: 7000),
      ],
    ),
  ],
),

// ── Juta (shoes) example ──
ProductCardModel(
  company: 'Bata Bangladesh',
  name: 'Classic Leather Formal Shoe',
  currentPrice: 1800,
  originalPrice: 2400,
  MOQ: 10,
  imageUrl: 'https://example.com/shoe.png',
  discountPercent: 25,
  specs: {
    'Material': 'Genuine Leather',
    'Origin': 'Bangladesh',
  },
  priceTiers: const [
    PriceTier(minQty: 10, maxQty: 49, price: 2400),
    PriceTier(minQty: 50, maxQty: 99, price: 2100),
    PriceTier(minQty: 100, price: 1800), // 100+ (maxQty default = infinity)
  ],
  variations: [
    VariationGroup(
      name: 'Color',
      isColorType: true,
      options: [
        VariationOption(label: 'Black', colorValue: Colors.black, stock: 500),
        VariationOption(label: 'Brown', colorValue: Colors.brown, stock: 320),
        VariationOption(label: 'Tan', colorValue: Colors.orange.shade300, stock: 0),
      ],
    ),
    VariationGroup(
      name: 'Size',
      options: [
        VariationOption(label: '7', stock: 100),
        VariationOption(label: '8', stock: 150),
        VariationOption(label: '9', stock: 200),
        VariationOption(label: '10', stock: 80),
      ],
    ),
  ],
),
];

final List<CouponModel> dummyCoupons = [
  CouponModel(
    title: "Bulk Order Discount",
    description: "Min order ৳1,00,000",
    code: "BULK15",
    discountLabel: "15%",
    discountSubLabel: "OFF",
    validityText: "Valid till Dec 31",
    status: "Available",
  ),
  CouponModel(
    title: "Free Shipping Voucher",
    description: "On orders above ৳50,000",
    code: "FREESHIP50",
    discountLabel: "FREE",
    discountSubLabel: "SHIP",
    validityText: "Expires in 2 days",
    status: "Available",
  ),
  CouponModel(
    title: "First Bulk Order",
    description: "Flat ৳5,000 off",
    code: "FIRST5K",
    discountLabel: "৳5,000",
    discountSubLabel: "OFF",
    validityText: "Valid till Jan 15",
    status: "Available",
  ),
  CouponModel(
    title: "Laptop Category Special",
    description: "Above 5 units",
    code: "LAPTOP10",
    discountLabel: "10%",
    discountSubLabel: "OFF",
    validityText: "Expires in 5 hrs",
    status: "Available",
  ),
];
