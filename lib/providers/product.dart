import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    this.isFavourite = false,
    @required this.title,
    @required this.imageUrl,
    @required this.id,
    @required this.description,
    @required this.price,
  });
  void _setFavouriteValue(bool newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavouriteStatus(String token, String userId) async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;

    final url = Uri.parse(
        'https://shop-app-1082a-default-rtdb.firebaseio.com/userFavourites/$userId/$id.json?auth=$token');
    try {
      final response = await http.put(
        url,
        body: json.encode(isFavourite),
      );
      if (response.statusCode >= 400) {
        _setFavouriteValue(oldStatus);
      }
      notifyListeners();
    } catch (error) {
      _setFavouriteValue(oldStatus);
    }
  }
}
