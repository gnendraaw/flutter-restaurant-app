import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

class FavoriteProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  FavoriteProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await databaseHelper.getFavorites();
    if (_favorites.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favResto = await databaseHelper.getFavoriteById(id);
    return favResto.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.deleteFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }
}
