import 'package:flutter/material.dart';

class CartManager {
  static final List<Map<String, dynamic>> items = [];

  static void addItem(String name, int price) {
    final index = items.indexWhere((element) => element['name'] == name);
    if (index >= 0) {
      items[index]['quantity'] = (items[index]['quantity'] as int) + 1;
    } else {
      items.add({
        'name': name,
        'price': price,
        'quantity': 1,
      });
    }
  }

  static void removeItem(int index) {
    if (index >= 0 && index < items.length) {
      if ((items[index]['quantity'] as int) > 1) {
        items[index]['quantity'] = (items[index]['quantity'] as int) - 1;
      } else {
        items.removeAt(index);
      }
    }
  }

  static void addItemQuantity(int index) {
    if (index >= 0 && index < items.length) {
      items[index]['quantity'] = (items[index]['quantity'] as int) + 1;
    }
  }

  static int get totalCount => items.fold(0, (sum, item) => sum + (item['quantity'] as int));

  static int get totalPrice => items.fold(0, (sum, item) => sum + ((item['price'] as int) * (item['quantity'] as int)));
}

class CategoryScreen extends StatefulWidget {
  final String categoryName;
  final Color categoryColor;
  final IconData categoryIcon;

  const CategoryScreen({
    Key? key,
    required this.categoryName,
    required this.categoryColor,
    required this.categoryIcon,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Map<String, dynamic>> _getVendors() {
    if (widget.categoryName.contains('المطاعم')) {
      return [
        {
          'id': 'v1',
          'name': 'مطعم الشجرة العدني',
          'type': 'مأكولات شعبية ومشاوي',
          'rating': '4.9',
          'time': '20-30 دقيقة',
          'products': [
            {'name': 'وجبة زربيان لحم عدني', 'price': '4500', 'desc': 'لحم بلدي طازج مع الأرز والبهارات العدنية'},
            {'name': 'صحن مشويات مشكلة', 'price': '6000', 'desc': 'كباب، أوصال، وطاووق مع سلطة وحمص'},
            {'name': 'فتة تمر بالقيمر', 'price': '1800', 'desc': 'فتة عدنية أصلية بالسمن البلدي والعسل'},
          ]
        },
        {
          'id': 'v2',
          'name': 'مطعم وشواية الملاكي',
          'type': 'مضغوط وشواية',
          'rating': '4.7',
          'time': '25-35 دقيقة',
          'products': [
            {'name': 'وجبة مضغوط دجاج', 'price': '3200', 'desc': 'نصف حبة دجاج مع أرز بسمتي فاخر'},
            {'name': 'دجاج شواية كامل مع أرز', 'price': '5500', 'desc': 'دجاج محمر مع أرز وسلطات'},
          ]
        },
      ];
    } else if (widget.categoryName.contains('الصيدليات')) {
      return [
        {
          'id': 'v3',
          'name': 'صيدلية ابن خلدون المركزية',
          'type': 'أدوية ومستلزمات طبية',
          'rating': '4.8',
          'time': '15-25 دقيقة',
          'products': [
            {'name': 'بنادول إكسترا (24 أقراص)', 'price': '1200', 'desc': 'مسكن للآلام ومخفض للحرارة'},
            {'name': 'فيتامين سي فوار 1000mg', 'price': '2500', 'desc': 'مكمل غذائي لدعم المناعة Daily Immunity'},
            {'name': 'جهاز قياس الضغط الرقمي', 'price': '18000', 'desc': 'دقيق جداً مع شاشة رقمية وجراب'},
          ]
        },
      ];
    } else {
      return [
        {
          'id': 'v4',
          'name': 'متجر الفائق - ${widget.categoryName}',
          'type': 'متجر معتمد',
          'rating': '4.8',
          'time': '20-40 دقيقة',
          'products': [
            {'name': 'منتج معتمد 1', 'price': '3000', 'desc': 'متوفر للتوصيل الفوري'},
            {'name': 'منتج معتمد 2', 'price': '5500', 'desc': 'خامة ممتازة وجودة عالية'},
          ]
        },
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final vendors = _getVendors();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('متاجر قسم ${widget.categoryName}'),
          backgroundColor: const Color(0xFF1E3A8A),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.categoryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: widget.categoryColor.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: widget.categoryColor,
                      child: Icon(widget.categoryIcon, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('المتاجر والبائعين المتاحين', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        const Text('اختر المخبز أو المطعم أو الصيدلية לרؤية المنتجات', style: TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('قائمة المتاجر في عدن', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: vendors.length,
                  itemBuilder: (context, index) {
                    final vendor = vendors[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 2,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: CircleAvatar(
                          radius: 26,
                          backgroundColor: widget.categoryColor.withOpacity(0.15),
                          child: Icon(Icons.storefront, color: widget.categoryColor, size: 28),
                        ),
                        title: Text(vendor['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(vendor['type'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 14),
                                const SizedBox(width: 2),
                                Text(vendor['rating'], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                                const SizedBox(width: 12),
                                const Icon(Icons.access_time, color: Colors.grey, size: 14),
                                const SizedBox(width: 2),
                                Text(vendor['time'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF1E3A8A)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => VendorProductsScreen(
                                vendorName: vendor['name'],
                                products: List<Map<String, String>>.from(vendor['products']),
                                themeColor: widget.categoryColor,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VendorProductsScreen extends StatefulWidget {
  final String vendorName;
  final List<Map<String, String>> products;
  final Color themeColor;

  const VendorProductsScreen({
    Key? key,
    required this.vendorName,
    required this.products,
    required this.themeColor,
  }) : super(key: key);

  @override
  State<VendorProductsScreen> createState() => _VendorProductsScreenState();
}

class _VendorProductsScreenState extends State<VendorProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.vendorName),
          backgroundColor: const Color(0xFF1E3A8A),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('منتجات وسلع ${widget.vendorName}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.products.length,
                  itemBuilder: (context, index) {
                    final item = widget.products[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: widget.themeColor.withOpacity(0.15),
                              child: Icon(Icons.shopping_bag_outlined, color: widget.themeColor),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                  const SizedBox(height: 4),
                                  Text(item['desc']!, style: const TextStyle(fontSize: 11, color: Colors.grey), maxLines: 2, overflow: TextOverflow.ellipsis),
                                  const SizedBox(height: 6),
                                  Text('${item['price']} ر.ي', style: const TextStyle(color: Color(0xFF16A34A), fontWeight: FontWeight.bold, fontSize: 13)),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  CartManager.addItem(item['name']!, int.parse(item['price']!));
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('تمت إضافة "${item['name']}" إلى السلة بنجاح!'),
                                    backgroundColor: const Color(0xFF16A34A),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E3A8A),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text('شراء / إضافة', style: TextStyle(color: Colors.white, fontSize: 11)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
