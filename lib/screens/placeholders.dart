import 'package:flutter/material.dart';

class ProductItem {
  final String id;
  final String name;
  final String storeName;
  final double price;
  final String category;
  final String imageUrl;

  ProductItem({
    required this.id,
    required this.name,
    required this.storeName,
    required this.price,
    required this.category,
    required this.imageUrl,
  });
}

class StoreItem {
  final String id;
  final String name;
  final String category;
  final String rating;
  final String deliveryTime;
  final String imageUrl;

  StoreItem({
    required this.id,
    required this.name,
    required this.category,
    required this.rating,
    required this.deliveryTime,
    required this.imageUrl,
  });
}

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

// قائمة المتاجر موزعة حسب الأقسام الحقيقية
final List<StoreItem> mockStores = [
  // السوبرماركت
  StoreItem(id: 's1', name: 'سوبرماركت البركة', category: 'السوبرماركت', rating: '4.8', deliveryTime: '20-30 دقيقة', imageUrl: ''),
  StoreItem(id: 's2', name: 'أسواق المدينة المركزية', category: 'السوبرماركت', rating: '4.7', deliveryTime: '25-35 دقيقة', imageUrl: ''),
  
  // المطاعم والوجبات
  StoreItem(id: 's3', name: 'مطعم السعيد للمأكولات', category: 'المطاعم والوجبات', rating: '4.6', deliveryTime: '30-45 دقيقة', imageUrl: ''),
  StoreItem(id: 's4', name: 'مطاعم الشيباني الحديثة', category: 'المطاعم والوجبات', rating: '4.9', deliveryTime: '20-40 دقيقة', imageUrl: ''),

  // الصيدليات والأدوية
  StoreItem(id: 's5', name: 'صيدلية الشفاء الحديثة', category: 'الصيدليات والأدوية', rating: '4.9', deliveryTime: '15-25 دقيقة', imageUrl: ''),
  StoreItem(id: 's6', name: 'صيدلية العافية الدولية', category: 'الصيدليات والأدوية', rating: '4.8', deliveryTime: '10-20 دقيقة', imageUrl: ''),

  // أدوات التجميل
  StoreItem(id: 's7', name: 'مركز الجمال والأنشطة', category: 'أدوات التجميل', rating: '4.7', deliveryTime: '30-50 دقيقة', imageUrl: ''),
  StoreItem(id: 's8', name: 'عالم العطور والتجميل', category: 'أدوات التجميل', rating: '4.8', deliveryTime: '25-40 دقيقة', imageUrl: ''),

  // الملابس والأزياء
  StoreItem(id: 's9', name: 'بوتيك الأزياء العصرية', category: 'الملابس والأزياء', rating: '4.5', deliveryTime: '40-60 دقيقة', imageUrl: ''),

  // الفنادق والحجوزات
  StoreItem(id: 's10', name: 'فندق وكافيه الفائق', category: 'الفنادق والحجوزات', rating: '5.0', deliveryTime: 'حجز فوري', imageUrl: ''),

  // المراكز الطبية
  StoreItem(id: 's11', name: 'مركز الأمل الطبي التخصصي', category: 'المراكز الطبية', rating: '4.9', deliveryTime: 'مواعيد فورية', imageUrl: ''),

  // التوصيل والمالية
  StoreItem(id: 's12', name: 'خدمات الفائق للتوصيل السريع', category: 'التوصيل والمالية', rating: '4.9', deliveryTime: 'توصيل مباشر', imageUrl: ''),
];

final List<ProductItem> mockProducts = [
  ProductItem(id: 'p1', name: 'وجبة غداء مشكل فاخر', storeName: 'مطعم السعيد', price: 3500.0, category: 'المطاعم والوجبات', imageUrl: ''),
  ProductItem(id: 'p2', name: 'حليب المراعي 1 ليتر', storeName: 'سوبرماركت البركة', price: 1200.0, category: 'السوبرماركت', imageUrl: ''),
  ProductItem(id: 'p3', name: 'فواكه طبيعية مشكلة', storeName: 'سوبرماركت البركة', price: 800.0, category: 'السوبرماركت', imageUrl: ''),
];

// شاشة عرض المتاجر المخصصة لكل قسم
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
    // تصفية المتاجر حسب القسم المحدد
    final categoryStores = mockStores.where((s) => s.category == categoryName).toList();

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
                  Text('لا توجد متاجر مسجلة حالياً في قسم $categoryName', style: const TextStyle(fontSize: 16, color: Colors.grey)),
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
                    subtitle: Text('الوقت المتوقع: ${store.deliveryTime}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        Text(' ${store.rating}'),
                      ],
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('تم فتح متجر ${store.name}')),
                      );
                    },
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
      appBar: AppBar(
        title: const Text('خريطة التوصيل وتحديد الموقع'),
        backgroundColor: const Color(0xFF1A365D),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blueGrey[50],
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, size: 60, color: Colors.red),
                    SizedBox(height: 10),
                    Text('عدن - خور مكسر', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A365D)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم تأكيد موقع التوصيل!')));
              },
              child: const Text('تأكيد موقع التوصيل', style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = CartManager.cartItems;
    return Scaffold(
      appBar: AppBar(title: const Text('سلة التسوق'), backgroundColor: const Color(0xFF1A365D), foregroundColor: Colors.white),
      body: items.isEmpty
          ? const Center(child: Text('السلة فارغة'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text('${item.price} ر.ي x ${item.quantity}'),
                        trailing: Text('${item.price * item.quantity} ر.ي'),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class AdvancedSearchScreen extends StatelessWidget {
  const AdvancedSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('البحث المتقدم'), backgroundColor: const Color(0xFF1A365D), foregroundColor: Colors.white),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: TextField(
          decoration: InputDecoration(hintText: 'ابحث عن متجر أو منتج...', border: OutlineInputBorder()),
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
      appBar: AppBar(title: const Text('المحفظة والدفع الإلكتروني'), backgroundColor: const Color(0xFF1A365D), foregroundColor: Colors.white),
      body: const Center(child: Text('إدارة الرصيد ووسائل الدفع')),
    );
  }
}

class VendorDashboardScreen extends StatelessWidget {
  const VendorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لوحة تحكم المدير والتجار'), backgroundColor: const Color(0xFF1A365D), foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.add_a_photo, color: Colors.blue),
            title: const Text('إضافة منتج جديد'),
            onTap: () => Navigator.pushNamed(context, '/add_product'),
          ),
        ],
      ),
    );
  }
}
