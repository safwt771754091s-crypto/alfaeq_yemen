import 'package:flutter/material.dart';

class VendorAddProductScreen extends StatefulWidget {
  const VendorAddProductScreen({super.key});

  @override
  State<VendorAddProductScreen> createState() => _VendorAddProductScreenState();
}

class _VendorAddProductScreenState extends State<VendorAddProductScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  String _selectedCategory = 'المطاعم والوجبات';

  final List<String> _categories = [
    'الملابس والأزياء',
    'أدوات التجميل',
    'المطاعم والوجبات',
    'السوبرماركت',
    'الفنادق والحجوزات',
    'الصيدليات والأدوية',
    'المراكز الطبية',
    'التوصيل والمالية'
  ];

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'اسم المنتج', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'السعر (ريال يمني)', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'القسم', border: OutlineInputBorder()),
                items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (val) => setState(() => _selectedCategory = val!),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _descController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'وصف المنتج', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A365D)),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم حفظ المنتج بنجاح!')),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('حفظ ونشر المنتج', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
