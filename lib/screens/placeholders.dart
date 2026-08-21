import 'package:flutter/material.dart';

// Catch-all dynamic screen for missing screens
class DynamicPlaceholderScreen extends StatelessWidget {
  final dynamic title;
  const DynamicPlaceholderScreen([this.title, dynamic a, dynamic b, dynamic c]) : super();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title?.toString() ?? "الشاشة")),
        body: const Center(child: Text("قيد التطوير")),
      );
}

// Named screens required by main.dart
class CategoryScreen extends DynamicPlaceholderScreen { const CategoryScreen([super.a, super.b, super.c]); }
class YemenMapsScreen extends DynamicPlaceholderScreen { const YemenMapsScreen([super.a, super.b, super.c]); }
class PaymentWalletScreen extends DynamicPlaceholderScreen { const PaymentWalletScreen([super.a, super.b, super.c]); }
class CartScreen extends DynamicPlaceholderScreen { const CartScreen([super.a, super.b, super.c]); }
class AdvancedSearchScreen extends DynamicPlaceholderScreen { const AdvancedSearchScreen([super.a, super.b, super.c]); }
class VendorDashboardScreen extends DynamicPlaceholderScreen { const VendorDashboardScreen([super.a, super.b, super.c]); }
class NotificationServiceScreen extends DynamicPlaceholderScreen { const NotificationServiceScreen([super.a, super.b, super.c]); }
class SuperAdminDashboardScreen extends DynamicPlaceholderScreen { const SuperAdminDashboardScreen([super.a, super.b, super.c]); }

// Services & Handlers
class CartManager { static final items = []; static void clear() {} static void add(dynamic item) {} }
class OfflineCacheService { static void init() {} }
