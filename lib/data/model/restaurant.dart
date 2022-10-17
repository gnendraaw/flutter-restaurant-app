import 'dart:convert';

List<Restaurant> parseRestaurant(String? json) {
  if (json == null) return [];

  final Map<String, dynamic> parsed = jsonDecode(json);
  List<dynamic> restaurants = parsed['restaurants'];
  return restaurants.map((json) => Restaurant.fromJson(json)).toList();
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        rating: json['rating'].toDouble(),
        menus: Menus.fromJson(json['menus']),
      );
}

class Menus {
  final List<Foods> foods;
  final List<Drinks> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Foods>.from(json['foods'].map((x) => Foods.fromJson(x))),
        drinks:
            List<Drinks>.from(json['drinks'].map((x) => Drinks.fromJson(x))),
      );
}

class Foods {
  final String name;

  Foods({required this.name});

  factory Foods.fromJson(Map<String, dynamic> json) => Foods(
        name: json['name'],
      );
}

class Drinks {
  final String name;

  Drinks({
    required this.name,
  });

  factory Drinks.fromJson(Map<String, dynamic> json) => Drinks(
        name: json['name'],
      );
}
