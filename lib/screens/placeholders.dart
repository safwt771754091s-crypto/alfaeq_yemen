import 'package:flutter/material.dart';

class DynamicPlaceholderScreen extends StatelessWidget {
  final String title;
  const DynamicPlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('صفحة $title')),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  final String? categoryName;
  const CategoryScreen({super.key, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryName ?? 'القسم')),
      body: Center(child: Text('عرض قسم: ${categoryName ?? "غير محدد"}')),
    );
  }
}

class VendorDashboardScreen extends StatelessWidget {
  const VendorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لوحة تحكم التاجر')),
      body: const Center(child: Text('صفحة لوحة تحكم التاجر')),
    );
  }
}
