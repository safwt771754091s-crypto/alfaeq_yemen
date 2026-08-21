import 'package:flutter/material.dart';
import 'screens/placeholders.dart';

void main() {
  runApp(const AlfaeqYemenApp());
}

class AlfaeqYemenApp extends StatelessWidget {
  const AlfaeqYemenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'الفائق يمن',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  String selectedCity = 'عدن - خور مكسر';

  final List<String> yemenCities = [
    'عدن - خور مكسر',
    'عدن - الشيخ عثمان',
    'صنعاء - السبعين',
    'مأرب - المجمع',
    'تعز - شارع جمال',
    'حضرموت - المكلا',
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomeScreen(context),
      const AdvancedSearchScreen(),
      const YemenMapsScreen(),
      const PaymentWalletScreen(),
      _buildMoreMenuScreen(context),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'البحث'),
          BottomNavigationBarItem(icon: Icon(Icons.near_me), label: 'التوصيل'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'المحفظة'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'المزيد'),
        ],
      ),
    );
  }

  Widget _buildHomeScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A365D),
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.location_on, color: Colors.amber, size: 20),
            const SizedBox(width: 6),
            DropdownButton<String>(
              value: selectedCity,
              dropdownColor: const Color(0xFF1A365D),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
              underline: const SizedBox(),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() => selectedCity = newValue);
                }
              },
              items: yemenCities.map<DropdownMenuItem<String>>((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAlignment.start,
          children: [
            // شريط البحث
            Container(
              color: const Color(0xFF1A365D),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'ابحث عن صيدلية، مطعم، منتج، أو حجز...',
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // الأقسام الرئيسية
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('الأقسام الرئيسية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _buildCategoryCard(context, 'الملابس والأزياء', Icons.checkroom, Colors.blue),
                _buildCategoryCard(context, 'أدوات التجميل', Icons.face, Colors.purple),
                _buildCategoryCard(context, 'المطاعم والوجبات', Icons.restaurant, Colors.orange),
                _buildCategoryCard(context, 'السوبرماركت', Icons.shopping_basket, Colors.green),
                _buildCategoryCard(context, 'الفنادق والحجوزات', Icons.hotel, Colors.teal),
                _buildCategoryCard(context, 'الصيدليات والأدوية', Icons.medical_services, Colors.red),
                _buildCategoryCard(context, 'المراكز الطبية', Icons.add_business, Colors.indigo),
                _buildCategoryCard(context, 'التوصيل والمالية', Icons.local_shipping, Colors.lightBlue),
              ],
            ),

            const SizedBox(height: 25),

            // قسم الأكثر طلباً / المنتجات الشائعة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('الأكثر طلباً اليوم 🔥', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: const Text('عرض الكل')),
                ],
              ),
            ),

            SizedBox(
              height: 190,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: mockProducts.length,
                itemBuilder: (context, index) {
                  final p = mockProducts[index];
                  return Container(
                    width: 140,
                    margin: const EdgeInsets.only(left: 12),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.network(p.imageUrl, height: 90, width: double.infinity, fit: BoxFit.cover,
                                errorBuilder: (ctx, _, __) => Container(height: 90, color: Colors.grey[300], child: const Icon(Icons.fastfood))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAlignment.start,
                              children: [
                                Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 1),
                                Text(p.storeName, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${p.price} ر.ي', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
                                    InkWell(
                                      onTap: () {
                                        CartManager.addItem(CartItem(id: p.id, name: p.name, price: p.price));
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تمت إضافة ${p.name} للسلة'), duration: const Duration(seconds: 1)));
                                      },
                                      child: const CircleAvatar(radius: 12, backgroundColor: Color(0xFF1A365D), child: Icon(Icons.add, size: 16, color: Colors.white)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // المتاجر المقترحة
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('المتاجر المعتمدة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: mockStores.length,
              itemBuilder: (context, index) {
                final store = mockStores[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(backgroundImage: NetworkImage(store.imageUrl), child: const Icon(Icons.store)),
                    title: Text(store.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${store.category} • ${store.deliveryTime}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        Text('${store.rating}'),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryScreen(categoryName: store.name)));
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, IconData icon, Color color) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryScreen(categoryName: title, categoryColor: color, categoryIcon: icon)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center, maxLines: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildMoreMenuScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المزيد / الإعدادات'), backgroundColor: const Color(0xFF1A365D), foregroundColor: Colors.white),
      body: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('صفوت محمد حسان'),
            accountEmail: Text('الإدارة العلياء - الفائق يمن'),
            currentAccountPicture: CircleAvatar(backgroundColor: Colors.amber, child: Icon(Icons.person, size: 40, color: Colors.white)),
            decoration: BoxDecoration(color: Color(0xFF1A365D)),
          ),
          ListTile(
            leading: const Icon(Icons.admin_panel_settings, color: Colors.red),
            title: const Text('لوحة تحكم المدير والتجار', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('إضافة وتعديل المنتجات والمتاجر والطلبات'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const VendorDashboardScreen()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.map, color: Colors.blue),
            title: const Text('خريطة التوصيل وتحديد الموقع'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const YemenMapsScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart, color: Colors.green),
            title: const Text('سلة التسوق'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet, color: Colors.orange),
            title: const Text('المحفظة والرصيد'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentWalletScreen()));
            },
          ),
        ],
      ),
    );
  }
}
