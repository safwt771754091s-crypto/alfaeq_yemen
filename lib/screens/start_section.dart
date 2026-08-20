import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../data/sample_data.dart';
import 'shop_list_screen.dart';

class StartSection extends StatelessWidget {
  const StartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(title: Text(tr('start_section'))),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tr('start_intro_title'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(tr('start_intro_body')),
              const SizedBox(height: 18),
              Expanded(
                child: GridView.builder(
                  itemCount: SampleData.services.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.15),
                  itemBuilder: (context, index) {
                    final svc = SampleData.services[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => ShopListScreen(service: svc)));
                      },
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6),
                        ]),
                        padding: const EdgeInsets.all(12),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          CircleAvatar(backgroundColor: svc.color.withOpacity(0.12), child: Icon(svc.icon, color: svc.color)),
                          const SizedBox(height: 8),
                          Text(svc.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        ]),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
