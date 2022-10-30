import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

void main() {
  test('should contain Restaurant list when http call completed', () async {
    // arrange
    final RestaurantResult restaurantResult;

    // act
    restaurantResult = await ApiService().restaurantList();

    // assert
    var result = restaurantResult.restaurants.isNotEmpty;

    expect(result, true);
  });
}
