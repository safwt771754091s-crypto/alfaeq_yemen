import 'package:flutter/material.dart';
import 'placeholders.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _categories = [
    {'title': 'السوبرماركت', 'icon': Icons.local_grocery_store, 'color': Colors.green, 'route': '/supermarket'},
    {'title': 'المطاعم والوجبات', 'icon': Icons.restaurant, 'color': Colors.orange, 'route': '/restaurants'},
    {'title': 'أدوات التجميل', 'icon': Icons.face_retouching_natural, 'color': Colors.purple, 'route': '/beauty'},
    {'title': 'الملابس والأزياء', 'icon': Icons.checkroom, 'color': Colors.blue, 'route': '/fashion'},
    {'title': 'التوصيل والطلبات', 'icon': Icons.local_shipping, 'color': Colors.teal, 'route': '/delivery'},
    {'title': 'الصيدليات والأدوية', 'icon': Icons.local_hospital, 'color': Colors.red, 'route': '/pharmacy'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A365D),
        elevation: 2,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.amber,
              child: Icon(Icons.person, color: Color(0xFF1A365D)),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  CurrentUser.name, // ظهور اسمك صفوت محمد حسان بشكل واضح
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.amber, size: 12),
                    SizedBox(width: 2),
                    Text('اليمن - صنعاء / عدن', style: TextStyle(fontSize: 11, color: Colors.white70)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // بنر ترحيبي عالي الجودة
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF1A365D), Color(0xFF2B6CB0)]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('أهلاً بك ${CurrentUser.name}', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 4),
                        const Text('تطبيق سوق اليمن الشامل للمتاجر والتوصيل', style: TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                  const Icon(Icons.storefront, size: 50, color: Colors.white30),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Text('الأقسام الرئيسية', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A365D))),
            const SizedBox(height: 10),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                return InkWell(
                  onTap: () => Navigator.pushNamed(context, cat['route']),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(cat['icon'], color: cat['color'], size: 30),
                        const SizedBox(height: 6),
                        Text(cat['title'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),
            const Text('المنتجات المضافة حديثاً 🔥', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A365D))),
            const SizedBox(height: 10),

            // إظهار منتج راني المضاف مباشرة
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: globalProducts.length,
              itemBuilder: (context, index) {
                final prod = globalProducts[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.local_drink, color: Colors.orange, size: 32),
                    title: Text(prod.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('المتجر: ${prod.storeName} | القسم: ${prod.category}'),
                    trailing: Text('${prod.price} ر.ي', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15)),
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
