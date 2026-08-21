import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class VendorAddProductScreen extends StatefulWidget {
  const VendorAddProductScreen({super.key});

  @override
  State<VendorAddProductScreen> createState() => _VendorAddProductScreenState();
}

class _VendorAddProductScreenState extends State<VendorAddProductScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _storeIdController = TextEditingController();
  final FirebaseService _service = FirebaseService();
  bool _isLoading = false;

  void _submitData() async {
    if (_nameController.text.isEmpty || _priceController.text.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      await _service.addProduct({
        'name': _nameController.text,
        'price': double.parse(_priceController.text),
        'storeId': _storeIdController.text.isEmpty ? 'default_store' : _storeIdController.text,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تمت إضافة المنتج بنجاح!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ في الإضافة: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة منتج جديد')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'اسم المنتج'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'السعر (ر.ي)'),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _submitData,
                    child: const Text('حفظ ونشر المنتج'),
                  ),
          ],
        ),
      ),
    );
  }
}
