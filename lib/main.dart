import 'package:alfaeq_yemen/screens/placeholders.dart';
import 'screens/placeholders.dart';
import 'screens/placeholders.dart';
import 'screens/placeholders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp( AlFaeqApp());
}

class AlFaeqApp extends StatelessWidget {
   AlFaeqApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'الفائق يمن',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor:  Color(0xFF0F172A),
        scaffoldBackgroundColor:  Color(0xFFF1F5F9),
        fontFamily: 'Arial',
      ),
      home:  MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
   MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  void _refreshCart() {
    setState(() {});
  }

  Future<bool> _onWillPop() async {
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title:  Text('تأكيد الخروج', style: TextStyle(fontWeight: FontWeight.bold)),
          content:  Text('هل توافق على الخروج من تطبيق الفائق يمن؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child:  Text('لا / إلغاء', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              onPressed: () => SystemNavigator.pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor:  Color(0xFFDC2626),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child:  Text('نعم، خروج', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('المتاجر الأكثر شعبية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: mockStores.length,
                itemBuilder: (context, index) {
                  final store = mockStores[index];
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.only(left: 12),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAlignment.start,
                          children: [
                            Text(store.name, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1),
                            Text(store.category, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(store.deliveryTime, style: const TextStyle(fontSize: 11, color: Colors.blue)),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 14),
                                    Text('${store.rating}', style: const TextStyle(fontSize: 12)),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
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
    return shouldPop ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreenContent(onCartUpdated: _refreshCart),
      AdvancedSearchScreen(),
       YemenMapsScreen(),
       PaymentWalletScreen(),
       MoreMenuScreen(),
    ];

    int totalCartCount = CartManager.totalCount;
    int totalCartPrice = CartManager.totalPrice;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Stack(
            children: [
              IndexedStack(
                index: _currentIndex,
                children: screens,
              ),
              if (totalCartCount > 0)
                Positioned(
                  bottom: 12,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color:  Color(0xFF16A34A),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset:  Offset(0, 4)),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                             Icon(Icons.shopping_cart_rounded, color: Colors.white, size: 24),
                             SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'السلة ($totalCartCount عناصر)',
                                  style:  TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                                Text(
                                  'الإجمالي: $totalCartPrice ر.ي',
                                  style:  TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await Navigator.push(context, MaterialPageRoute(builder: (_) =>  CartScreen()));
                            _refreshCart();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor:  Color(0xFF16A34A),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 0,
                          ),
                          child:  Text('عرض السلة', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset:  Offset(0, -4),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor:  Color(0xFF1E3A8A),
              unselectedItemColor:  Color(0xFF94A3B8),
              selectedLabelStyle:  TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              unselectedLabelStyle:  TextStyle(fontSize: 11),
              elevation: 0,
              items:  [
                BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'الرئيسية'),
                BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'البحث'),
                BottomNavigationBarItem(icon: Icon(Icons.near_me_rounded), label: 'التوصيل'),
                BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_rounded), label: 'المحفظة'),
                BottomNavigationBarItem(icon: Icon(Icons.menu_rounded), label: 'المزيد'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  final VoidCallback onCartUpdated;
   HomeScreenContent({Key? key, required this.onCartUpdated}) : super(key: key);

  final List<Map<String, dynamic>> categories =  [
    {'name': 'الملابس والأزياء', 'icon': Icons.checkroom, 'color': Color(0xFF2563EB)},
    {'name': 'أدوات التجميل', 'icon': Icons.face_retouching_natural, 'color': Color(0xFFD946EF)},
    {'name': 'المطاعم والوجبات', 'icon': Icons.restaurant, 'color': Color(0xFFF97316)},
    {'name': 'السوبرماركت', 'icon': Icons.shopping_basket_rounded, 'color': Color(0xFF16A34A)},
    {'name': 'الفنادق والحجوزات', 'icon': Icons.hotel_rounded, 'color': Color(0xFF0891B2)},
    {'name': 'الصيدليات والأدوية', 'icon': Icons.medical_services_rounded, 'color': Color(0xFFDC2626)},
    {'name': 'المراكز الطبية', 'icon': Icons.local_hospital_rounded, 'color': Color(0xFF4F46E5)},
    {'name': 'التوصيل والمالية', 'icon': Icons.local_shipping_rounded, 'color': Color(0xFF0284C7)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xFF1E3A8A),
        elevation: 0,
        toolbarHeight: 70,
        title: Row(
          children: [
             Icon(Icons.location_on_rounded, color: Colors.amber, size: 20),
             SizedBox(width: 4),
             Text('التوصيل إلى: ', style: TextStyle(fontSize: 12, color: Colors.white70)),
             Text('عدن - خور مكسر', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
             Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 18),
             Spacer(),
            IconButton(
              icon: Stack(
                children: [
                   Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 26),
                  if (CartManager.totalCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding:  EdgeInsets.all(2),
                        decoration:  BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        constraints:  BoxConstraints(minWidth: 14, minHeight: 14),
                        child: Text(
                          '${CartManager.totalCount}',
                          style:  TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              onPressed: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (_) =>  CartScreen()));
                onCartUpdated();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics:  BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color:  Color(0xFF1E3A8A),
              padding:  EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'ابحث عن صيدلية، مطعم، منتج، أو حجز...',
                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                    prefixIcon:  Icon(Icons.search_rounded, color: Color(0xFF1E3A8A)),
                    border: InputBorder.none,
                    contentPadding:  EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),
             SizedBox(height: 20),
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('الأقسام الرئيسية', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
            ),
             SizedBox(height: 12),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics:  NeverScrollableScrollPhysics(),
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.82,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final item = categories[index];
                  return InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryScreen(
                            categoryName: item['name'],
                            categoryColor: item['color'],
                            categoryIcon: item['icon'],
                          ),
                        ),
                      );
                      onCartUpdated();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6, offset:  Offset(0, 2)),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: (item['color'] as Color).withOpacity(0.1),
                            child: Icon(item['icon'] as IconData, color: item['color'] as Color, size: 22),
                          ),
                           SizedBox(height: 8),
                          Text(
                            item['name'] as String,
                            style:  TextStyle(fontWeight: FontWeight.w600, fontSize: 10, color: Color(0xFF334155)),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
             SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class MoreMenuScreen extends StatelessWidget {
   MoreMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('لوحات التحكم والأدوات'),
        backgroundColor:  Color(0xFF1E3A8A),
        centerTitle: true,
      ),
      body: ListView(
        padding:  EdgeInsets.all(16),
        children: [
          _buildMenuCard(
            context,
            title: 'لوحة تحكم البائع والتاجر',
            subtitle: 'إدارة المنتجات الخمسين والمخزون والطلبات',
            icon: Icons.storefront,
            color: Colors.blue,
            target: VendorDashboardScreen(),
          ),
          _buildMenuCard(
            context,
            title: 'لوحة المدير الشامل ومهندس AI',
            subtitle: 'إدارة المنصة بالكامل والذكاء الاصطناعي',
            icon: Icons.admin_panel_settings,
            color: Colors.indigo,
            target: Container(),
          ),
          _buildMenuCard(
            context,
            title: 'مركز الإشعارات والتنبيهات',
            subtitle: 'تنبيهات الطلبات المباشرة والعروض',
            icon: Icons.notifications_active,
            color: Colors.amber,
            target: Container(),
          ),
          _buildMenuCard(
            context,
            title: 'وضع Off-line والمزامنة',
            subtitle: 'حالة التخزين المحلي والعمل بدون إنترنت',
            icon: Icons.wifi_off,
            color: Colors.teal,
            target: SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Widget target,
  }) {
    return Card(
      margin:  EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style:  TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style:  TextStyle(fontSize: 12)),
        trailing:  Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => target));
        },
      ),
    );
  }
}
