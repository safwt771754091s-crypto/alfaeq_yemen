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

class PaymentMethod {
  final String id;
  final String name;
  final String accountNumber;
  bool isEnabled;

  PaymentMethod({required this.id, required this.name, required this.accountNumber, this.isEnabled = true});
}

// قائمة المنتجات المعروضة
final List<ProductItem> globalProducts = [
  ProductItem(id: 'p1', name: 'عصير راني مانجو', storeName: 'سوبرماركت البركة', price: 200, category: 'السوبرماركت'),
];

// قائمة المحافظ المتاحة
final List<PaymentMethod> mockWallets = [
  PaymentMethod(id: 'w1', name: 'حاسب / بنك الكريمي', accountNumber: '1234567'),
  PaymentMethod(id: 'w2', name: 'محفظة تداول', accountNumber: '777000111'),
  PaymentMethod(id: 'w3', name: 'محفظة جيب - Jaib', accountNumber: '733000222'),
  PaymentMethod(id: 'w4', name: 'محفظة جوالي', accountNumber: '711000333'),
];

// قائمة المتاجر مع رابط البائع الخاص
final List<StoreItem> mockStores = [
  StoreItem(id: 's1', name: 'سوبرماركت البركة', category: 'السوبرماركت', rating: '4.8', deliveryTime: '20-30 دقيقة', vendorInviteLink: 'https://app.yemen.express/vendor/add?id=s1'),
  StoreItem(id: 's2', name: 'مطعم السعيد للمأكولات', category: 'المطاعم والوجبات', rating: '4.6', deliveryTime: '30-45 دقيقة', vendorInviteLink: 'https://app.yemen.express/vendor/add?id=s2'),
  StoreItem(id: 's3', name: 'صيدلية الشفاء الحديثة', category: 'الصيدليات والأدوية', rating: '4.9', deliveryTime: '15-25 دقيقة', vendorInviteLink: 'https://app.yemen.express/vendor/add?id=s3'),
];

// شاشة المحفظة وسداد الفواتير
class PaymentWalletScreen extends StatefulWidget {
  const PaymentWalletScreen({super.key});

  @override
  State<PaymentWalletScreen> createState() => _PaymentWalletScreenState();
}

class _PaymentWalletScreenState extends State<PaymentWalletScreen> {
  @override
  Widget build(BuildContext context) {
    final activeWallets = mockWallets.where((w) => w.isEnabled).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('المحفظة وسداد الفواتير'),
        backgroundColor: const Color(0xFF1A365D),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A365D),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('الرصيد المتاح', style: TextStyle(color: Colors.white70, fontSize: 14)),
                      SizedBox(height: 5),
                      Text('150,000 ر.ي', style: TextStyle(color: Colors.amber, fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Icon(Icons.account_balance_wallet, color: Colors.white, size: 40),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('وسائل الدفع الإلكتروني المتاحة:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: activeWallets.length,
                itemBuilder: (context, index) {
                  final wallet = activeWallets[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.payment, color: Colors.green),
                      title: Text(wallet.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('رقم الحساب/المحفظة: ${wallet.accountNumber}'),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A365D)),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم اختيار ${wallet.name} للشحن/الدفع')));
                        },
                        child: const Text('دفع / شحن', style: TextStyle(color: Colors.white, fontSize: 12)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// لوحة المدير المتقدمة (إدارة المتاجر، إصدار رابط البائع، والمحافظ)
class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final _vendorNameController = TextEditingController();
  final _vendorCategoryController = TextEditingController();

  void _addVendor() {
    if (_vendorNameController.text.isNotEmpty) {
      final newId = 's${mockStores.length + 1}';
      setState(() {
        mockStores.add(StoreItem(
          id: newId,
          name: _vendorNameController.text,
          category: _vendorCategoryController.text.isEmpty ? 'عام' : _vendorCategoryController.text,
          rating: '5.0',
          deliveryTime: '20-30 دقيقة',
          vendorInviteLink: 'https://app.yemen.express/vendor/add?id=$newId',
        ));
      });
      _vendorNameController.clear();
      _vendorCategoryController.clear();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إضافة البائع وإنشاء رابط المشاركة له!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('لوحة التحكم والإدارة'),
          backgroundColor: const Color(0xFF1A365D),
          foregroundColor: Colors.white,
          bottom: const TabBar(
            labelColor: Colors.amber,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.store), text: 'إدارة المتاجر وروابط البائعين'),
              Tab(icon: Icon(Icons.account_balance), text: 'إدارة المحافظ'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A365D)),
                      icon: const Icon(Icons.add_business, color: Colors.white),
                      label: const Text('إضافة بائع جديد وإصدار رابط له', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => Padding(
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('إضافة متجر / بائع جديد', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                TextField(controller: _vendorNameController, decoration: const InputDecoration(labelText: 'اسم المتجر', border: OutlineInputBorder())),
                                const SizedBox(height: 10),
                                TextField(controller: _vendorCategoryController, decoration: const InputDecoration(labelText: 'القسم', border: OutlineInputBorder())),
                                const SizedBox(height: 15),
                                ElevatedButton(onPressed: _addVendor, child: const Text('حفظ وإصدار رابط للبائع')),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: mockStores.length,
                      itemBuilder: (context, index) {
                        final store = mockStores[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ExpansionTile(
                            leading: CircleAvatar(
                              backgroundColor: store.isActive ? Colors.green : Colors.red,
                              child: const Icon(Icons.store, color: Colors.white),
                            ),
                            title: Text(store.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('القسم: ${store.category}'),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SelectableText('رابط إضافة المنتجات للبائع:\n${store.vendorInviteLink}', style: const TextStyle(color: Colors.blue, fontSize: 13)),
                                    const SizedBox(height: 10),
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber.shade800),
                                      icon: const Icon(Icons.share, size: 16, color: Colors.white),
                                      label: const Text('مشاركة الرابط للبائع', style: TextStyle(color: Colors.white, fontSize: 12)),
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم نسخ رابط متجر ${store.name}!')));
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: mockWallets.length,
              itemBuilder: (context, index) {
                final wallet = mockWallets[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.account_balance_wallet, color: Colors.blue),
                    title: Text(wallet.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('الحساب: ${wallet.accountNumber}'),
                    trailing: Switch(
                      value: wallet.isEnabled,
                      onChanged: (val) {
                        setState(() => wallet.isEnabled = val);
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// شاشة خدمات التوصيل وتتبع الطلبات (بديل الخريطة)
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

// شاشة القسم المحدثة
class CategoryScreen extends StatelessWidget {
  final String categoryName;
  const CategoryScreen({super.key, required this.categoryName, Color? categoryColor, IconData? categoryIcon});

  @override
  Widget build(BuildContext context) {
    final categoryProducts = globalProducts.where((p) => p.category == categoryName).toList();
    final categoryStores = mockStores.where((s) => s.category == categoryName).toList();

    return Scaffold(
      appBar: AppBar(title: Text('قسم $categoryName'), backgroundColor: const Color(0xFF1A365D), foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('المنتجات المتاحة:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            categoryProducts.isEmpty
                ? const Text('لا توجد منتجات مضافة لهذا القسم حالياً', style: TextStyle(color: Colors.grey))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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
            const Divider(height: 30),
            const Text('المتاجر المتاحة:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categoryStores.length,
              itemBuilder: (context, index) {
                final s = categoryStores[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.store, color: Color(0xFF1A365D)),
                    title: Text(s.name),
                    subtitle: Text('توصيل: ${s.deliveryTime}'),
                    trailing: Text('⭐ ${s.rating}'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('سلة التسوق')), body: const Center(child: Text('سلة التسوق والتنفيذ')));
}

class AdvancedSearchScreen extends StatelessWidget {
  const AdvancedSearchScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('البحث الشامل')), body: const Center(child: Text('البحث الذكي')));
}

class VendorDashboardScreen extends StatelessWidget {
  const VendorDashboardScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('لوحة البائع'), backgroundColor: const Color(0xFF1A365D), foregroundColor: Colors.white),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.add_a_photo, color: Colors.blue),
                title: const Text('إضافة منتج جديد لمتجرك'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => Navigator.pushNamed(context, '/add_product'),
              ),
            ),
          ],
        ),
      );
}
