import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../config.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(title: Text(tr('settings'))),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tr('language'), style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => context.setLocale(const Locale('ar')),
                    child: const Text('العربية'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => context.setLocale(const Locale('en')),
                    child: const Text('English'),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(tr('delivery_settings'), style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ValueListenableBuilder<bool>(
                valueListenable: AppConfig.freeDelivery,
                builder: (context, free, _) {
                  return SwitchListTile(
                    title: Text(tr('free_delivery')),
                    value: free,
                    onChanged: (v) async {
                      await AppConfig.setFreeDelivery(v);
                      setState(() {});
                    },
                  );
                },
              ),
              const SizedBox(height: 18),
              Text(tr('currency'), style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ValueListenableBuilder<String>(
                valueListenable: AppConfig.currency,
                builder: (context, cur, _) {
                  return DropdownButton<String>(
                    value: cur,
                    items: const [
                      DropdownMenuItem(value: 'SAR', child: Text('SAR (ر.ي)')),
                      DropdownMenuItem(value: 'USD', child: Text('USD (4)')),
                      DropdownMenuItem(value: 'EGP', child: Text('EGP (E£)')),
                    ],
                    onChanged: (v) async {
                      if (v != null) {
                        await AppConfig.setCurrency(v);
                        setState(() {});
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
