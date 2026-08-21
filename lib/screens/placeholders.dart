import 'package:flutter/material.dart';

// أنواع الأدوار والصلاحيات
enum UserRole { admin, vendor, customer }

class CurrentUser {
  static UserRole role = UserRole.admin;
  static String name = "صفوت محمد حسان";
  static String storeName = "متجر الفائق الإلكتروني";
}

// نماذج البيانات
class ProductItem {
  final String id;
  final String name;
  final String storeName;
  final double price;
  final String category;

  ProductItem({required this.id, required this.name, required this.storeName, required this.price, required this.category});
}

class StoreItem {
  final String id;
  final String name;
  final String category;
  final String rating;
  final String deliveryTime;
  bool isActive;

  StoreItem({required this.id, required this.name, required this.category, required this.rating, required this.deliveryTime, this.isActive = true});
}

class PaymentMethod {
  final String id;
  final String name;
  final String accountNumber;
  bool isEnabled;

  PaymentMethod({required this.id, required this.name, required this.accountNumber, this.isEnabled = true});
}

// بيانات المحافظ الإلكترونية المتاحة في اليمن
final List<PaymentMethod> mockWallets = [
  PaymentMethod(id: 'w1', name: 'حاسب / بنك الكريمي', accountNumber: '1234567'),
  PaymentMethod(id: 'w2', name: 'محفظة تداول', accountNumber: '777000111'),
  PaymentMethod(id: 'w3', name: 'محفظة جيب - Jaib', accountNumber: '733000222'),
  PaymentMethod(id: 'w4', name: 'محفظة جوالي', accountNumber: '711000333'),
];

// بيانات المتاجر المعتمدة
final List<StoreItem> mockStores = [
  StoreItem(id: 's1', name: 'سوبرماركت البركة', category: 'السوبرماركت', rating: '4.8', deliveryTime: '20-30 دقيقة'),
  StoreItem(id: 's2', name: 'مطعم السعيد للمأكولات', category: 'المطاعم والوجبات', rating: '4.6', deliveryTime: '30-45 دقيقة'),
  StoreItem(id: 's3', name: 'صيدلية الشفاء الحديثة', category: 'الصيدليات والأدوية', rating: '4.9', deliveryTime: '15-25 دقيقة'),
  StoreItem(id: 's4', name: 'مركز الجمال والأناقة', category: 'أدوات التجميل', rating: '4.7', deliveryTime: '25-40 دقيقة'),
];

class CartItem {
  final String id;
  final String name;
  final double price;
  int quantity;

  CartItem({required this.id, required this.name, required this.price, this.quantity = 1});
}

class CartManager {
  static final List<CartItem> cartItems = [];

  static void addItem(CartItem item) {
    int index = cartItems.indexWhere((element) => element.id == item.id);
    if (index != -1) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(item);
    }
  }

  static double getTotalPrice() {
    return cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }
}

// شاشة المحفظة والدفع للمستخدم والمدير
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

// شاشة إدارة البائعين والمحافظ (خاصة بالمدير فقط)
class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final _vendorNameController = TextEditingController();
  final _vendorCategoryController = TextEditingController();

  final _walletNameController = TextEditingController();
  final _walletAccountController = TextEditingController();

  void _addVendor() {
    if (_vendorNameController.text.isNotEmpty) {
      setState(() {
        mockStores.add(StoreItem(
          id: 's${mockStores.length + 1}',
          name: _vendorNameController.text,
          category: _vendorCategoryController.text.isEmpty ? 'عام' : _vendorCategoryController.text,
          rating: '5.0',
          deliveryTime: '20-30 دقيقة',
        ));
      });
      _vendorNameController.clear();
      _vendorCategoryController.clear();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إضافة البائع/المتجر الجديد بنجاح!')));
    }
  }

  void _addWallet() {
    if (_walletNameController.text.isNotEmpty) {
      setState(() {
        mockWallets.add(PaymentMethod(
          id: 'w${mockWallets.length + 1}',
          name: _walletNameController.text,
          accountNumber: _walletAccountController.text,
        ));
      });
      _walletNameController.clear();
      _walletAccountController.clear();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إضافة المحفظة الإلكترونية بنجاح!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('لوحة التحكم الإدارية (المدير)'),
          backgroundColor: const Color(0xFF1A365D),
          foregroundColor: Colors.white,
          bottom: const TabBar(
            labelColor: Colors.amber,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.store), text: 'إدارة البائعين'),
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
                      label: const Text('إضافة بائع / متجر جديد', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => Padding(
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('إضافة بائع جديد', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                TextField(controller: _vendorNameController, decoration: const InputDecoration(labelText: 'اسم المتجر / البائع', border: OutlineInputBorder())),
                                const SizedBox(height: 10),
                                TextField(controller: _vendorCategoryController, decoration: const InputDecoration(labelText: 'القسم (مطاعم، سوبرماركت...)', border: OutlineInputBorder())),
                                const SizedBox(height: 15),
                                ElevatedButton(onPressed: _addVendor, child: const Text('حفظ وإعتماد البائع')),
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
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: store.isActive ? Colors.green : Colors.red,
                              child: const Icon(Icons.store, color: Colors.white),
                            ),
                            title: Text(store.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('القسم: ${store.category}'),
                            trailing: Switch(
                              value: store.isActive,
                              onChanged: (val) {
                                setState(() => store.isActive = val);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      icon: const Icon(Icons.add_card, color: Colors.white),
                      label: const Text('إضافة محفظة إلكترونية جديدة', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => Padding(
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('إضافة محفظة دفع جديدة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                TextField(controller: _walletNameController, decoration: const InputDecoration(labelText: 'اسم المحفظة / البنك', border: OutlineInputBorder())),
                                const SizedBox(height: 10),
                                TextField(controller: _walletAccountController, decoration: const InputDecoration(labelText: 'رقم الحساب / الهاتف', border: OutlineInputBorder())),
                                const SizedBox(height: 15),
                                ElevatedButton(onPressed: _addWallet, child: const Text('تفعيل المحفظة')),
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  final String categoryName;
  final Color categoryColor;
  final IconData categoryIcon;

  const CategoryScreen({
    super.key,
    required this.categoryName,
    this.categoryColor = const Color(0xFF1A365D),
    this.categoryIcon = Icons.store,
  });

  @override
  Widget build(BuildContext context) {
    final categoryStores = mockStores.where((s) => s.category == categoryName && s.isActive).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('متاجر $categoryName'),
        backgroundColor: categoryColor,
        foregroundColor: Colors.white,
      ),
      body: categoryStores.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(categoryIcon, size: 70, color: categoryColor.withOpacity(0.4)),
                  const SizedBox(height: 15),
                  Text('لا توجد متاجر معتمدة حالياً في قسم $categoryName', style: const TextStyle(fontSize: 16, color: Colors.grey)),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('العودة للرئيسية'),
                  )
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: categoryStores.length,
              itemBuilder: (context, index) {
                final store = categoryStores[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: categoryColor.withOpacity(0.2),
                      child: Icon(categoryIcon, color: categoryColor),
                    ),
                    title: Text(store.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('وقت التوصيل: ${store.deliveryTime}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        Text(' ${store.rating}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class YemenMapsScreen extends StatelessWidget {
  const YemenMapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('خريطة التوصيل وتحديد الموقع'), backgroundColor: const Color(0xFF1A365D), foregroundColor: Colors.white),
      body: const Center(child: Text('خريطة التوصيل المباشر')),
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سلة التسوق'), backgroundColor: const Color(0xFF1A365D), foregroundColor: Colors.white),
      body: const Center(child: Text('سلة التسوق')),
    );
  }
}

class AdvancedSearchScreen extends StatelessWidget {
  const AdvancedSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('البحث الشامل'), backgroundColor: const Color(0xFF1A365D), foregroundColor: Colors.white),
      body: const Center(child: Text('البحث عن المتاجر والمنتجات')),
    );
  }
}

class VendorDashboardScreen extends StatelessWidget {
  const VendorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لوحة تحكم البائع (إضافة المنتجات)'), backgroundColor: const Color(0xFF1A365D), foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.add_a_photo, color: Colors.blue),
              title: const Text('إضافة منتج جديد لمتجرك'),
              subtitle: const Text('إدراج الصور، السعر، والتفاصيل'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.pushNamed(context, '/add_product'),
            ),
          ),
        ],
      ),
    );
  }
}
