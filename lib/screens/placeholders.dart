import 'package:flutter/material.dart';

// نموذج المنتج
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

// مدير السلة وحساب المبالغ
class CartManager {
  static final List<CartItem> items = [];
  static final ValueNotifier<int> itemCountNotifier = ValueNotifier<int>(0);

  static int get totalCount => items.fold(0, (sum, item) => sum + item.quantity);

  static double get totalPrice => items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

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

  static void clearCart() {
    items.clear();
    itemCountNotifier.value = 0;
  }
}

// الشاشات المؤقتة لتفادي أخطاء البناء
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

// شاشة السلة التفاعلية لعرض المنتجات والمجموع الحقيقي
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
                        subtitle: Text('السعر: \$${item.price} × ${item.quantity}'),
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
                      Text('\$${CartManager.totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
