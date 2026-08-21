import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // جلب المتاجر من قاعدة البيانات الحقيقية
  Stream<QuerySnapshot> getStores() {
    return _db.collection('stores').snapshots();
  }

  // جلب المنتجات حسب القسم أو المتجر
  Stream<QuerySnapshot> getProductsByStore(String storeId) {
    return _db.collection('products').where('storeId', isEqualTo: storeId).snapshots();
  }

  // إضافة منتج جديد (لوحة التاجر)
  Future<void> addProduct(Map<String, dynamic> productData) async {
    await _db.collection('products').add(productData);
  }

  // إنشاء طلب جديد
  Future<void> createOrder(Map<String, dynamic> orderData) async {
    await _db.collection('orders').add(orderData);
  }
}
