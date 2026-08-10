import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final IconData icon;

  Product({required this.id, required this.name, required this.description, required this.price, this.icon = Icons.shopping_bag});
}

class Shop {
  final String id;
  final String name;
  final String address;
  final IconData icon;
  final List<Product> products;

  Shop({required this.id, required this.name, required this.address, required this.products, this.icon = Icons.store});
}

class Service {
  final String id;
  final String title;
  final IconData icon;
  final Color color;
  final List<Shop> shops;

  Service({required this.id, required this.title, required this.icon, required this.color, required this.shops});
}
