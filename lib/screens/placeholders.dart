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

// مدير السلة
class CartManager {
  static final List<CartItem> items = [];
  static final ValueNotifier<int> itemCountNotifier = ValueNotifier<int>(0);

  static int get totalCount => items.fold(0, (sum, item) => sum + item.quantity);

  // إرجاع القيمة كـ int مباشرة لتطابق المتغير int totalCartPrice في main.dart
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

  static void clearCart() {
    items.clear();
    itemCountNotifier.value = 0;
  }
}

// الشاشات
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
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName ?? 'القسم'),
        backgroundColor: categoryColor is Color ? categoryColor : null,
      ),
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

class PaymentWalletScreen extends StatelessWidget {
  const PaymentWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المحفظة / وسائل الدفع')),
      body: const Center(child: Text('صفحة إدارة المحفظة والدفع')),
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
                      Text('\$${CartManager.totalPrice.toString()}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
