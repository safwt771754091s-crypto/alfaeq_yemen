import 'package:flutter/material.dart';

enum UserRole { admin, vendor, customer }

class CurrentUser {
  static UserRole role = UserRole.admin;
  static String name = "صفوت محمد حسان";
  static String storeName = "متجر الفائق الإلكتروني";
}

class ProductItem {
  final String id;
  final String name;
  final String storeName;
  final double price;
  final String category;

  ProductItem({
    required this.id,
    required this.name,
    required this.storeName,
    required this.price,
    required this.category,
  });
}

class StoreItem {
  final String id;
  final String name;
  final String category;
  final String rating;
  final String deliveryTime;
  final String vendorInviteLink;
  bool isActive;

  StoreItem({
    required this.id,
    required this.name,
    required this.category,
    required this.rating,
    required this.deliveryTime,
    required this.vendorInviteLink,
    this.isActive = true,
  });
}

final List<ProductItem> globalProducts = [
  ProductItem(id: 'p1', name: 'عصير راني مانجو', storeName: 'سوبرماركت البركة', price: 200, category: 'السوبرماركت'),
];

final List<StoreItem> mockStores = [
  StoreItem(id: 's1', name: 'سوبرماركت البركة', category: 'السوبرماركت', rating: '4.8', deliveryTime: '20-30 دقيقة', vendorInviteLink: 'https://app.yemen.express/vendor/add?id=s1'),
  StoreItem(id: 's2', name: 'مطعم السعيد للمأكولات', category: 'المطاعم والوجبات', rating: '4.6', deliveryTime: '30-45 دقيقة', vendorInviteLink: 'https://app.yemen.express/vendor/add?id=s2'),
];

class YemenMapsScreen extends StatelessWidget {
  const YemenMapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('خدمات التوصيل وتتبع الطلبات'),
        backgroundColor: const Color(0xFF1A365D),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: const [
                  Icon(Icons.directions_bike, color: Color(0xFF1A365D), size: 36),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('حالة التوصيل المباشر', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text('يتم إسناد الكباتن والمناديب فور إتمام الطلب', style: TextStyle(fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('الطلبات الجارية للتوصيل:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  Card(
                    child: ListTile(
                      leading: CircleAvatar(backgroundColor: Colors.orange, child: Icon(Icons.delivery_dining, color: Colors.white)),
                      title: Text('طلب رقم #1024 - عصير راني'),
                      subtitle: Text('الحالة: جاري تجهيز الطلب مع المندوب'),
                      trailing: Text('قيد التوصيل', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentWalletScreen extends StatelessWidget {
  const PaymentWalletScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المحفظة وسداد الفواتير'), backgroundColor: const Color(0xFF1A365D), foregroundColor: Colors.white),
      body: const Center(child: Text('خدمات الدفع والمحفظة')),
    );
  }
}

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لوحة التحكم والإدارة'), backgroundColor: const Color(0xFF1A365D), foregroundColor: Colors.white),
      body: const Center(child: Text('لوحة التحكم الإدارية')),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  final String categoryName;
  const CategoryScreen({super.key, required this.categoryName, Color? categoryColor, IconData? categoryIcon});

  @override
  Widget build(BuildContext context) {
    final categoryProducts = globalProducts.where((p) => p.category == categoryName).toList();
    return Scaffold(
      appBar: AppBar(title: Text('قسم $categoryName'), backgroundColor: const Color(0xFF1A365D), foregroundColor: Colors.white),
      body: categoryProducts.isEmpty
          ? const Center(child: Text('لا توجد منتجات مضافة حالياً في هذا القسم'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: categoryProducts.length,
              itemBuilder: (context, index) {
                final p = categoryProducts[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.shopping_bag, color: Colors.orange),
                    title: Text(p.name),
                    subtitle: Text(p.storeName),
                    trailing: Text('${p.price} ر.ي', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  ),
                );
              },
            ),
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('سلة التسوق')), body: const Center(child: Text('السلة')));
}

class AdvancedSearchScreen extends StatelessWidget {
  const AdvancedSearchScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('البحث')), body: const Center(child: Text('شاشة البحث')));
}

class VendorDashboardScreen extends StatelessWidget {
  const VendorDashboardScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('لوحة البائع')), body: const Center(child: Text('لوحة البائع')));
}
