import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  List<String> _favoriteProducts = [];

  List<String> get favoriteProducts => _favoriteProducts;

  // Initialize the favorite products from SharedPreferences
  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favoriteProducts = prefs.getStringList('favorites') ?? [];
    notifyListeners();
  }

  // Add a product to the favorites
  Future<void> addFavorite(String productId) async {
    if (!_favoriteProducts.contains(productId)) {
      _favoriteProducts.add(productId);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favorites', _favoriteProducts);
      notifyListeners();
    }
  }

  // Remove a product from the favorites
  Future<void> removeFavorite(String productId) async {
    if (_favoriteProducts.contains(productId)) {
      _favoriteProducts.remove(productId);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favorites', _favoriteProducts);
      notifyListeners();
    }
  }

  // Check if a product is in the favorites
  bool isFavorite(String productId) {
    return _favoriteProducts.contains(productId);
  }
}
