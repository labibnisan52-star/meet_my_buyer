import 'package:flutter/material.dart';
import 'package:meet_my_app_buyer/models/product_card_model.dart';
import 'package:meet_my_app_buyer/models/variation_model.dart';

import '../models/cart_item_model.dart';
import '../models/cart_supplier_model.dart';

final List<CartSupplier> dummyCart = [
  CartSupplier(
    id: 's1',
    name: 'Dell Technologies BD',
    avatarText: 'DT',
    isVerified: true,
    items: [
      CartItem(
        id: 'p1',
        name: 'Dell Inspiron 15 Core i5 13th Gen — 8GB 512GB',
        category: 'Laptop',
        imageUrl: '',
        variant: 'Silver · Windows 11',
        pricePerUnit: 52000,
        bulkPrice: 48000,
        bulkMinQty: 50,
        quantity: 10,
      ),
      CartItem(
        id: 'p2',
        name: 'Samsung Galaxy A55 5G 128GB — Midnight Black',
        category: 'Mobile',
        imageUrl: '',
        variant: '',
        pricePerUnit: 28500,
        bulkPrice: 26000,
        bulkMinQty: 10,
        quantity: 20,
      ),
    ],
  ),
  CartSupplier(
    id: 's2',
    name: 'Sony Bangladesh',
    avatarText: 'SP',
    isVerified: false,
    items: [
      CartItem(
        id: 'p3',
        name: 'Sony WH-1000XM5 Wireless Noise Canceling',
        category: 'Audio',
        imageUrl: '',
        variant: '',
        pricePerUnit: 18000,
        bulkPrice: 16500,
        bulkMinQty: 5,
        quantity: 15,
      ),
    ],
  ),
];

final List<ProductCardModel> dummyProducts = [
  ProductCardModel(
    company: 'Sony',
    name: 'WH-1000XM5 Wireless Headphones',
    currentPrice: 299,
    originalPrice: 399,
    discountPercent: 25,
    MOQ: 100,
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTjUBlWLGTLfxCznEyn22cwzOyUHy6jdIWhE89xitWUw&s=10',
    specs: {
      "Type": "Over-Ear Wireless",
      "Noise Cancelling": "Active (ANC)",
      "Battery Life": "Up to 30 hours",
      "Connectivity": "Bluetooth 5.2",
    },
    priceTiers: const [
      PriceTier(minQty: 100, maxQty: 299, price: 399),
      PriceTier(minQty: 300, maxQty: 999, price: 349),
      PriceTier(minQty: 1000, price: 299), // 1000+ (maxQty default = infinity)
    ],
    variations: [
      VariationGroup(
        name: 'Color',
        isColorType: true,
        options: [
          VariationOption(label: 'Black', colorValue: Colors.black, stock: 900),
          VariationOption(
            label: 'Silver',
            colorValue: Colors.grey.shade300,
            stock: 650,
          ),
          VariationOption(
            label: 'Midnight Blue',
            colorValue: Colors.indigo.shade900,
            stock: 180,
          ),
        ],
      ),
    ],
  ),
  ProductCardModel(
    company: 'Samsung',
    name: 'Galaxy Tab S9 Ultra',
    currentPrice: 850,
    originalPrice: 1000,
    discountPercent: 15,
    MOQ: 50,
    imageUrl:
        'https://static0.anpoimages.com/wordpress/wp-content/uploads/2023/07/galaxy-tab-s9-ultra-lifestyle-topdown.jpg',
    specs: {
      "Display": "14.6 inch Dynamic AMOLED",
      "RAM": "12GB",
      "Storage": "256GB",
      "Battery": "11200mAh",
    },
    priceTiers: const [
      PriceTier(minQty: 50, maxQty: 149, price: 1000),
      PriceTier(minQty: 150, maxQty: 499, price: 920),
      PriceTier(minQty: 500, price: 850), // 500+ (maxQty default = infinity)
    ],
    variations: [
      VariationGroup(
        name: 'Color',
        isColorType: true,
        options: [
          VariationOption(
            label: 'Graphite',
            colorValue: Colors.grey.shade800,
            stock: 400,
          ),
          VariationOption(
            label: 'Beige',
            colorValue: Colors.brown.shade100,
            stock: 300,
          ),
          VariationOption(
            label: 'Mint',
            colorValue: Colors.teal.shade100,
            stock: 0,
          ), // out of stock
        ],
      ),
      VariationGroup(
        name: 'Storage',
        options: [
          VariationOption(label: '256GB', stock: 500),
          VariationOption(label: '512GB', stock: 220, priceDelta: 90),
          VariationOption(label: '1TB', stock: 80, priceDelta: 180),
        ],
      ),
    ],
  ),
  ProductCardModel(
    company: 'Apple',
    name: 'MacBook Air M2',
    currentPrice: 1099,
    originalPrice: 1299,
    discountPercent: 15,
    MOQ: 30,
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2UywLuilEnpbXp2utkXgVUdjmvhxbkBDPb_9mWP7gzQ&s=10',
    specs: {
      "Chip": "Apple M2",
      "RAM": "8GB",
      "Storage": "256GB SSD",
      "Display": "13.6 inch Liquid Retina",
    },
    priceTiers: const [
      PriceTier(minQty: 30, maxQty: 99, price: 1299),
      PriceTier(minQty: 100, maxQty: 299, price: 1199),
      PriceTier(minQty: 300, price: 1099), // 300+ (maxQty default = infinity)
    ],
    variations: [
      VariationGroup(
        name: 'Color',
        isColorType: true,
        options: [
          VariationOption(
            label: 'Space Gray',
            colorValue: Colors.grey.shade700,
            stock: 300,
          ),
          VariationOption(
            label: 'Silver',
            colorValue: Colors.grey.shade300,
            stock: 250,
          ),
          VariationOption(
            label: 'Starlight',
            colorValue: Colors.amber.shade100,
            stock: 180,
          ),
          VariationOption(
            label: 'Midnight',
            colorValue: Colors.indigo.shade900,
            stock: 90,
          ),
        ],
      ),
      VariationGroup(
        name: 'Storage',
        options: [
          VariationOption(label: '256GB SSD', stock: 300),
          VariationOption(label: '512GB SSD', stock: 150, priceDelta: 200),
          VariationOption(label: '1TB SSD', stock: 60, priceDelta: 450),
        ],
      ),
      VariationGroup(
        name: 'RAM',
        options: [
          VariationOption(label: '8GB', stock: 300),
          VariationOption(label: '16GB', stock: 130, priceDelta: 200),
        ],
      ),
    ],
  ),
  ProductCardModel(
    company: 'Logitech',
    name: 'MX Master 3S Wireless Mouse',
    currentPrice: 79,
    originalPrice: 99,
    discountPercent: 20,
    MOQ: 200,
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_UqdTMvpy-RbZqCawWQM32Gq9clU_wS06tdjavgsrqQ&s=10',
    specs: {
      "Connectivity": "Bluetooth / USB Receiver",
      "Battery Life": "Up to 70 days",
      "DPI": "8000",
      "Buttons": "7 Programmable",
    },
    priceTiers: const [
      PriceTier(minQty: 200, maxQty: 499, price: 99),
      PriceTier(minQty: 500, maxQty: 1999, price: 88),
      PriceTier(minQty: 2000, price: 79), // 2000+ (maxQty default = infinity)
    ],
    variations: [
      VariationGroup(
        name: 'Color',
        isColorType: true,
        options: [
          VariationOption(
            label: 'Graphite',
            colorValue: Colors.grey.shade800,
            stock: 1500,
          ),
          VariationOption(
            label: 'Pale Gray',
            colorValue: Colors.grey.shade300,
            stock: 900,
          ),
        ],
      ),
    ],
  ),
  ProductCardModel(
    company: 'Dell',
    name: 'UltraSharp 27" 4K Monitor',
    currentPrice: 450,
    originalPrice: 600,
    discountPercent: 25,
    MOQ: 20,
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOaMekabugxk-6LdHFFqzMBGabQOUc60kTHUKIGvjuPA&s=10',
    specs: {
      "Resolution": "3840 x 2160 (4K UHD)",
      "Panel Type": "IPS",
      "Refresh Rate": "60Hz",
      "Ports": "USB-C, HDMI, DisplayPort",
    },
    priceTiers: const [
      PriceTier(minQty: 20, maxQty: 49, price: 600),
      PriceTier(minQty: 50, maxQty: 199, price: 520),
      PriceTier(minQty: 200, price: 450), // 200+ (maxQty default = infinity)
    ],
    variations: [
      VariationGroup(
        name: 'Stand Type',
        options: [
          VariationOption(label: 'Standard Stand', stock: 220),
          VariationOption(label: 'Wall-Mount Only', stock: 90, priceDelta: -30),
        ],
      ),
    ],
  ),
];
