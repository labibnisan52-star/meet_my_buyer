import 'package:flutter/material.dart';
import 'package:meet_my_app_buyer/providers/cart_provider.dart';
import 'package:meet_my_app_buyer/providers/wishlist_provider.dart';
import 'package:meet_my_app_buyer/providers/rfq_provider.dart';
import 'package:meet_my_app_buyer/providers/post_provider.dart'; 
import 'package:meet_my_app_buyer/screens/navbar.dart';
import 'package:meet_my_app_buyer/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: const String.fromEnvironment('SUPABASE_URL'),
    anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => RFQProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainScreen(),
    );
  }
}
