import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// --- نماذج البيانات التجريبية ---
class StoreItem {
  final String id;
  final String name;
  final String category;
  final double rating;
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

class ProductItem {
  final String id;
  final String name;
  final double price;
  final String storeName;
  final String imageUrl;

  ProductItem({
    required this.id,
    required this.name,
    required this.price,
    required this.storeName,
    required this.imageUrl,
  });
}

// بيانات تجريبية للمتاجر والمنتجات
final List<StoreItem> mockStores = [
  StoreItem(
    id: 's1',
    name: 'سوبرماركت البركة',
    category: 'السوبرماركت',
    rating: 4.8,
    deliveryTime: '20-30 دقيقة',
    imageUrl: 'https://images.unsplash.com/photo-1578916171728-46686eac8d58?w=300',
  ),
  StoreItem(
    id: 's2',
    name: 'مطعم السعيد للمأكولات',
    category: 'المطاعم والوجبات',
    rating: 4.6,
    deliveryTime: '30-45 دقيقة',
    imageUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=300',
  ),
  StoreItem(
    id: 's3',
    name: 'صيدلية الشفاء الحديثة',
    category: 'الصيدليات والأدوية',
    rating: 4.9,
    deliveryTime: '15-25 دقيقة',
    imageUrl: 'https://images.unsplash.com/photo-1586015555751-63bb77f4322a?w=300',
  ),
];

final List<ProductItem> mockProducts = [
  ProductItem(
    id: 'p1',
    name: 'وجبة غداء مشكل فاخر',
    price: 3500,
    storeName: 'مطعم السعيد',
    imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=300',
  ),
  ProductItem(
    id: 'p2',
    name: 'حليب المراعى 1 ليتر',
    price: 1200,
    storeName: 'سوبرماركت البركة',
    imageUrl: 'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=300',
  ),
  ProductItem(
    id: 'p3',
    name: 'عصير فواكه طبيعي',
    price: 800,
    storeName: 'سوبرماركت البركة',
    imageUrl: 'https://images.unsplash.com/photo-1600271886742-f049cd451bba?w=300',
  ),
];

// --- إدارة السلة ---
class CartItem {
  final String id;
  final String name;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
  });
}

class CartManager {
  static final List<CartItem> items = [];
  static final ValueNotifier<int> itemCountNotifier = ValueNotifier<int>(0);

  static int get totalCount => items.fold(0, (sum, item) => sum + item.quantity);

  static int get totalPrice {
    double sum = items.fold(0.0, (s, item) => s + (item.price * item.quantity));
    return sum.toInt();
  }

  static void addItem(CartItem item) {
    int index = items.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      items[index].quantity++;
    } else {
      items.add(item);
    }
    itemCountNotifier.value = totalCount;
  }

  static void removeItem(String id) {
    items.removeWhere((item) => item.id == id);
    itemCountNotifier.value = totalCount;
  }
}

// --- شاشة خريطة اليمن والتوصيل التفاعلية ---
class YemenMapsScreen extends StatefulWidget {
  const YemenMapsScreen({super.key});

  @override
  State<YemenMapsScreen> createState() => _YemenMapsScreenState();
}

class _YemenMapsScreenState extends State<YemenMapsScreen> {
  // إحداثيات افتراضية لمدينة عدن / اليمن
  LatLng currentCenter = const LatLng(12.8000, 45.0333);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('خريطة التوصيل وتحديد الموقع'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: currentCenter,
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.alfaeq.yemen',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: currentCenter,
                    width: 50,
                    height: 50,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 45,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.my_location, color: Colors.blue),
                        SizedBox(width: 10),
                        Text('الموقع المحدد: عدن - خور مكسر', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800], foregroundColor: Colors.white),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تم تأكيد موقع التوصيل بنجاح!')),
                          );
                        },
                        child: const Text('تأكيد موقع التوصيل'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// --- شاشة تفاصيل الأقسام والمتاجر ---
class CategoryScreen extends StatelessWidget {
  final String? categoryName;
  final dynamic categoryColor;
  final dynamic categoryIcon;

  const CategoryScreen({
    super.key,
    this.categoryName,
    this.categoryColor,
    this.categoryIcon,
  });

  @override
  Widget build(BuildContext context) {
    final title = categoryName ?? 'القسم';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: categoryColor is Color ? categoryColor : Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAlignment.start,
          children: [
            Text('المتاجر المتاحة في $title', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...mockStores.map((store) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(store.imageUrl, width: 60, height: 60, fit: BoxFit.cover,
                          errorBuilder: (ctx, _, __) => const Icon(Icons.store, size: 40)),
                    ),
                    title: Text(store.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${store.category} • وقت التوصيل: ${store.deliveryTime}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        Text(' ${store.rating}'),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

// --- باقي الشاشات الاحتياطية ---
class AdvancedSearchScreen extends StatelessWidget {
  const AdvancedSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('البحث المتقدم')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: 'ابحث عن منتج، مطعم، صيدلية...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: mockProducts.length,
                itemBuilder: (context, index) {
                  final p = mockProducts[index];
                  return ListTile(
                    leading: const Icon(Icons.shopping_bag, color: Colors.blue),
                    title: Text(p.name),
                    subtitle: Text(p.storeName),
                    trailing: Text('${p.price} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class VendorDashboardScreen extends StatelessWidget {
  const VendorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لوحة تحكم التاجر')),
      body: const Center(child: Text('هنا يستطيع التاجر إضافة المنتجات والمتاجر والطلبات')),
    );
  }
}

class PaymentWalletScreen extends StatelessWidget {
  const PaymentWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المحفظة ووسائل الدفع')),
      body: const Center(child: Text('إدارة الرصيد والدفع الكترونياً')),
    );
  }
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سلة التسوق')),
      body: CartManager.items.isEmpty
          ? const Center(child: Text('السلة فارغة حالياً'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: CartManager.items.length,
                    itemBuilder: (context, index) {
                      final item = CartManager.items[index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text('السعر: ${item.price} ر.ي × ${item.quantity}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              CartManager.removeItem(item.id);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('المجموع الكلي:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('${CartManager.totalPrice} ر.ي', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}

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
