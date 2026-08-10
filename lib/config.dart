import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  static final ValueNotifier<bool> freeDelivery = ValueNotifier<bool>(true);
  static final ValueNotifier<String> currency = ValueNotifier<String>('SAR');

  static const _kFreeDeliveryKey = 'freeDeliveryAll';
  static const _kCurrencyKey = 'currencyCode';

  static Future<void> load() async {
    final sp = await SharedPreferences.getInstance();
    freeDelivery.value = sp.getBool(_kFreeDeliveryKey) ?? true;
    currency.value = sp.getString(_kCurrencyKey) ?? 'SAR';
  }

  static Future<void> setFreeDelivery(bool val) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool(_kFreeDeliveryKey, val);
    freeDelivery.value = val;
  }

  static Future<void> setCurrency(String code) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kCurrency_KEY, code);
    currency.value = code;
  }
}
