import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final dynamic category;
  const CategoryScreen([this.category, dynamic a, dynamic b]) : super();
  
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("الأقسام")),
        body: const Center(child: Text("قيد التطوير")),
      );
}

class YemenMapsScreen extends StatelessWidget { const YemenMapsScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("خريطة اليمن")), body: const Center(child: Text("قيد التطوير"))); }
class PaymentWalletScreen extends StatelessWidget { const PaymentWalletScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("المحفظة والدفع")), body: const Center(child: Text("قيد التطوير"))); }
class CartScreen extends StatelessWidget { const CartScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("السلة")), body: const Center(child: Text("قيد التطوير"))); }
class AdvancedSearchScreen extends StatelessWidget { const AdvancedSearchScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("البحث المتقدم")), body: const Center(child: Text("قيد التطوير"))); }
class VendorDashboardScreen extends StatelessWidget { const VendorDashboardScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("لوحة البائع")), body: const Center(child: Text("قيد التطوير"))); }
class NotificationServiceScreen extends StatelessWidget { const NotificationServiceScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("الإشعارات")), body: const Center(child: Text("قيد التطوير"))); }
class SuperAdminDashboardScreen extends StatelessWidget { const SuperAdminDashboardScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("لوحة الإدارة")), body: const Center(child: Text("قيد التطوير"))); }

class CartManager { static final items = []; static void clear() {} }
class OfflineCacheService { }
