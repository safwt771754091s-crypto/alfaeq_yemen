import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/translations', // <-- change the path as needed
      fallbackLocale: const Locale('ar'),
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: tr('app_name'),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primaryColor: const Color(0xff087f5b),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xff087f5b),
          secondary: const Color(0xff12a36f),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _formatPrice(BuildContext context, double value) {
    final localeName = context.locale.languageCode == 'ar' ? 'ar_SA' : 'en_US';
    final symbol = context.locale.languageCode == 'ar' ? 'ر.ي' : '\$';
    return NumberFormat.currency(locale: localeName, symbol: symbol).format(value);
  }

  @override
  Widget build(BuildContext context) {
    final priceExample = _formatPrice(context, 12345.5);

    return Directionality(
      textDirection: context.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr('app_name')),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.language),
              onPressed: () {
                // toggle language
                final newLocale = context.locale.languageCode == 'ar' ? const Locale('en') : const Locale('ar');
                context.setLocale(newLocale);
              },
              tooltip: tr('switch_language'),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tr('welcome'), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  hintText: tr('search_hint'),
                  prefixIcon: const Icon(Icons.search_rounded),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 18),
              Text(tr('sections'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              // example price
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(tr('price_example', namedArgs: {'price': priceExample})),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add_shopping_cart),
                        label: Text(tr('add_to_cart')),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    const Icon(Icons.local_shipping, color: Colors.green),
                    const SizedBox(width: 8),
                    Text(tr('free_delivery'), style: const TextStyle(color: Colors.green)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
