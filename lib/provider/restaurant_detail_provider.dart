import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchAllRestaurant(id);
  }

  late RestaurantDetailResult _restaurantList;
  late ResultState _state;
  late String _message;

  RestaurantDetailResult get restaurantList => _restaurantList;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> _fetchAllRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantDetail(id);
      _state = ResultState.hasData;
      notifyListeners();
      return _restaurantList = restaurant;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Oops! something went wrong, try again later';
    }
  }
}
