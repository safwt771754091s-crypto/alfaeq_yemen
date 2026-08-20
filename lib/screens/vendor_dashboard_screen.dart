import 'package:flutter/material.dart';

class VendorDashboardScreen extends StatelessWidget {
  const VendorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('لوحة البائع'),
          centerTitle: true,
        ),
        body: GridView.count(
          padding: const EdgeInsets.all(16),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _DashboardCard(
              icon: Icons.store,
              title: 'بيانات المتجر',
              onTap: () {},
            ),
            _DashboardCard(
              icon: Icons.inventory_2,
              title: 'المنتجات',
              onTap: () {},
            ),
            _DashboardCard(
              icon: Icons.shopping_bag,
              title: 'الطلبات',
              onTap: () {},
            ),
            _DashboardCard(
              icon: Icons.attach_money,
              title: 'المبيعات',
              onTap: () {},
            ),
            _DashboardCard(
              icon: Icons.local_offer,
              title: 'العروض',
              onTap: () {},
            ),
            _DashboardCard(
              icon: Icons.settings,
              title: 'إعدادات المتجر',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 42),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
