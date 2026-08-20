import 'package:flutter/material.dart';
import 'category_screen.dart';

class PaymentWalletScreen extends StatefulWidget {
  const PaymentWalletScreen({Key? key}) : super(key: key);

  @override
  State<PaymentWalletScreen> createState() => _PaymentWalletScreenState();
}

class _PaymentWalletScreenState extends State<PaymentWalletScreen> {
  int _walletBalance = 25000; // رصيد محفظة افتراضي بالريال اليمني
  String _selectedPaymentMethod = 'cod'; // cod, kuraimi, jawali, wallet
  String _selectedRegion = 'خور مكسر';
  int _deliveryFee = 1000;

  final Map<String, int> _deliveryRates = {
    'خور مكسر': 1000,
    'الكريتر': 1200,
    'المعلا': 1200,
    'التواهي': 1500,
    'الشيخ عثمان': 1500,
    'المنصورة': 1500,
    'دار سعد': 2000,
    'البريقة': 2500,
  };

  void _processPayment() {
    final subtotal = CartManager.totalPrice;
    if (subtotal == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('السلة فارغة! يرجى إضافة منتجات أولاً.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final totalAmount = subtotal + _deliveryFee;

    if (_selectedPaymentMethod == 'wallet') {
      if (_walletBalance < totalAmount) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('رصيد المحفظة غير كافٍ، يرجى تغذية الحساب أو اختيار طريقة أخرى.'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }
      setState(() {
        _walletBalance -= totalAmount;
      });
    }

    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: const [
              Icon(Icons.check_circle_rounded, color: Colors.green, size: 28),
              SizedBox(width: 8),
              Text('تم تأكيد الطلب بنجاح', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('رقم الطلب المرجعي: #AFY-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}'),
              const SizedBox(height: 8),
              Text('المنطقة: $_selectedRegion'),
              Text('إجمالي المنتجات: $subtotal ر.ي'),
              Text('رسوم التوصيل: $_deliveryFee ر.ي'),
              const Divider(height: 20),
              Text(
                'المبلغ الإجمالي: $totalAmount ر.ي',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF16A34A), fontSize: 15),
              ),
              const SizedBox(height: 8),
              Text(
                'طريقة الدفع: ${_getPaymentMethodName()}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                CartManager.items.clear();
                Navigator.of(context).pop();
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('موافق / العودة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  String _getPaymentMethodName() {
    switch (_selectedPaymentMethod) {
      case 'cod':
        return 'الدفع عند الاستلام (نقداً)';
      case 'kuraimi':
        return 'حاسب / الكريمي إكسبرس';
      case 'jawali':
        return 'محفظة جيب / بنك اليمن والكويت';
      case 'wallet':
        return 'محفظة الفائق الإلكترونية';
      default:
        return 'غير محدد';
    }
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = CartManager.totalPrice;
    final total = subtotal + _deliveryFee;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('المحفظة وبوابة الدفع'),
          backgroundColor: const Color(0xFF1E3A8A),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // كارت المحفظة
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E3A8A), Color(0xFF0F172A)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('محفظة الفائق كاش', style: TextStyle(color: Colors.white70, fontSize: 13)),
                        Icon(Icons.account_balance_wallet, color: Colors.amber, size: 24),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '$_walletBalance ر.ي',
                      style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _walletBalance += 10000;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تمت شحن المحفظة بـ 10,000 ر.ي (تجريبي)')),
                            );
                          },
                          icon: const Icon(Icons.add_circle, size: 16, color: Colors.white),
                          label: const Text('شحن المحفظة', style: TextStyle(color: Colors.white, fontSize: 12)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF16A34A),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              const Text('اختر منطقة التوصيل في عدن', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedRegion,
                    isExpanded: true,
                    items: _deliveryRates.keys.map((String region) {
                      return DropdownMenuItem<String>(
                        value: region,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(region, style: const TextStyle(fontWeight: FontWeight.w600)),
                            Text('رسوم التوصيل: ${_deliveryRates[region]} ر.ي', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedRegion = newValue!;
                        _deliveryFee = _deliveryRates[newValue]!;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 24),
              const Text('وسيلة الدفع المناسبة', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              _buildPaymentOption('cod', 'الدفع عند الاستلام (كاش)', Icons.payments_outlined, Colors.green),
              _buildPaymentOption('kuraimi', 'حاسب / بنك الكريمي إكسبرس', Icons.account_balance, Colors.blue),
              _buildPaymentOption('jawali', 'محفظة جيب (Jawali) / BOK', Icons.phone_android, Colors.purple),
              _buildPaymentOption('wallet', 'الخصم من محفظة الفائق', Icons.account_balance_wallet, Colors.amber.shade800),

              const SizedBox(height: 20),
              // تفاصيل الفاتورة
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('مجموع المنتجات:'),
                        Text('$subtotal ر.ي', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('تكلفة التوصيل:'),
                        Text('$_deliveryFee ر.ي', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('الإجمالي النهائي:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text('$total ر.ي', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF16A34A))),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _processPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('تأكيد الدفع وإرسال الطلب', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String value, String title, IconData icon, Color iconColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: _selectedPaymentMethod == value ? const Color(0xFF1E3A8A) : Colors.transparent,
          width: 2,
        ),
      ),
      child: RadioListTile<String>(
        value: value,
        groupValue: _selectedPaymentMethod,
        onChanged: (val) {
          setState(() {
            _selectedPaymentMethod = val!;
          });
        },
        title: Row(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
