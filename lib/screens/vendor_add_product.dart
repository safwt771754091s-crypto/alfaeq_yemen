import 'package:flutter/material.dart';

class VendorAddProductScreen extends StatefulWidget {
  const VendorAddProductScreen({super.key});

  @override
  State<VendorAddProductScreen> createState() => _VendorAddProductScreenState();
}

class _VendorAddProductScreenState extends State<VendorAddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCategory = 'المطاعم والوجبات';

  final List<String> _categories = [
    'المطاعم والوجبات',
    'السوبرماركت',
    'الصيدليات والأدوية',
    'أدوات التجميل',
    'الملابس والأزياء',
    'الفنادق والحجوزات',
    'المراكز الطبية',
    'التوصيل والمالية',
  ];

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم إضافة المنتج "${_productNameController.text}" بنجاح!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة منتج جديد'),
        backgroundColor: const Color(0xFF1A365D),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // اختيار صوره للمنتج
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('اختيار صورة من المعرض...')),
                  );
                },
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
                      SizedBox(height: 8),
                      Text('اضغط لإضافة صورة المنتج', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // اسم المنتج
              TextFormField(
                controller: _productNameController,
                decoration: const InputDecoration(
                  labelText: 'اسم المنتج',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.shopping_bag),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال اسم المنتج';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // السعر
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'السعر (ريال يمني)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال السعر';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // اختيار القسم
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'القسم',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
              ),
              const SizedBox(height: 15),

              // الوصف
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'وصف المنتج (اختياري)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              const SizedBox(height: 25),

              // زر الحفظ
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A365D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _saveProduct,
                  child: const Text(
                    'حفظ ونشر المنتج',
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
