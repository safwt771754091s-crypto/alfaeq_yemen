import 'package:flutter/material.dart';

class YemenMapsScreen extends StatefulWidget {
  const YemenMapsScreen({Key? key}) : super(key: key);

  @override
  State<YemenMapsScreen> createState() => _YemenMapsScreenState();
}

class _YemenMapsScreenState extends State<YemenMapsScreen> {
  int _orderStatusStep = 2; // 1: تم القبول, 2: جاري التوصيل, 3: تم التسليم
  final String _captainName = 'أحمد العدني';
  final String _captainPhone = '770000000';
  final String _vehicleInfo = 'دباب توك توك - أحمر (عدن 1234)';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تتبع التوصيل والخرائط'),
          backgroundColor: const Color(0xFF1E3A8A),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: const Color(0xFFE2E8F0),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.map_rounded, size: 90, color: Colors.indigo.shade200),
                          const SizedBox(height: 10),
                          const Text(
                            'خريطة عدن - خور مكسر / الشارع العام',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'جاري تحديث موقع الكابتن المباشر كل 5 ثوانٍ...',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 140,
                      right: 120,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF16A34A),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('الكابتن أحمد', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                          const Icon(Icons.two_wheeler, color: Color(0xFF16A34A), size: 36),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 80,
                      left: 100,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E3A8A),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('موقعك (البيت)', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                          const Icon(Icons.location_on, color: Colors.red, size: 38),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15, offset: const Offset(0, -4)),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatusStep('تم القبول', 1),
                      _buildStatusLine(1),
                      _buildStatusStep('جاري التوصيل', 2),
                      _buildStatusLine(2),
                      _buildStatusStep('تم التسليم', 3),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: Color(0xFF1E3A8A),
                        child: Icon(Icons.person, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_captainName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            const SizedBox(height: 2),
                            Text(_vehicleInfo, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: const Color(0xFF16A34A).withOpacity(0.15),
                        child: IconButton(
                          icon: const Icon(Icons.phone, color: Color(0xFF16A34A)),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('الاتصال بالكابتن على الرقم: $_captainPhone')),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusStep(String title, int step) {
    bool isDone = _orderStatusStep >= step;
    return Column(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: isDone ? const Color(0xFF16A34A) : Colors.grey.shade300,
          child: Icon(isDone ? Icons.check : Icons.circle, size: 12, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
            color: isDone ? const Color(0xFF16A34A) : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusLine(int step) {
    bool isDone = _orderStatusStep > step;
    return Expanded(
      child: Container(
        height: 2,
        color: isDone ? const Color(0xFF16A34A) : Colors.grey.shade300,
        margin: const EdgeInsets.symmetric(horizontal: 4),
      ),
    );
  }
}
