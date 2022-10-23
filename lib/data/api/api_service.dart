import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantResult> restaurantList() async {
    final response = await http.get(Uri.parse("${_baseUrl}list"));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }
}
