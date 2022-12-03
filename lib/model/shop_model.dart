import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ShopModel extends ChangeNotifier {
  final List<Item> _products = [];
  final Map<String, CartItem> _cart = {};
  final Map<String, Item> _favourites = {};

  UnmodifiableListView<Item> get products => UnmodifiableListView(_products);
  UnmodifiableMapView<String, Item> get favourites =>
      UnmodifiableMapView(_favourites);
  UnmodifiableMapView<String, CartItem> get cart => UnmodifiableMapView(_cart);

  double get cartTotal => _cart.values.fold(
      0, (previousValue, cartItem) => previousValue + cartItem.item.price);

  void fetchProducts() async {
    try {
      final res = await http.get(
        Uri.parse("https://shopping-api.deta.dev/products/all"),
      );

      final Map<String, dynamic> body = convert.jsonDecode(res.body);
      final data = body["data"] as List<dynamic>;
      _products.clear();
      for (var product in data) {
        _products.add(Item(
          product["product_id"],
          product["name"],
          product["price"],
          product["image"],
        ));
      }
      notifyListeners();
    } catch (err) {
      log(err.toString());
    }
  }

  ShopModel() {
    fetchProducts();
  }

  void addProduct(Item item) {
    _products.add(item);
    notifyListeners();
  }

  void toggleFavourites(Item item) {
    if (_favourites.containsKey(item.id)) {
      _favourites.removeWhere((key, _) => key == item.id);
    } else {
      _favourites[item.id] = item;
    }
    notifyListeners();
  }

  void addProductToCart(Item item) {
    if (_cart.containsKey(item.id)) {
      _cart[item.id]?.incrementCount();
    } else {
      _cart[item.id] = CartItem(item);
    }
    notifyListeners();
  }

  void decrementProductCount(Item item) {
    if (_cart.containsKey(item.id) && _cart[item.id]!.count > 1) {
      _cart[item.id]!.decrementCount();
    } else {
      _cart.remove(item.id);
    }
    notifyListeners();
  }
}

@immutable
class Item {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  const Item(this.id, this.name, this.price, this.imageUrl);
}

class CartItem {
  final Item item;
  int _count = 1;

  int get count => _count;

  CartItem(this.item);

  void incrementCount() => _count++;
  void decrementCount() {
    if (_count > 0) _count--;
  }
}
