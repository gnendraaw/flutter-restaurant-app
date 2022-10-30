import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetch restaurant', () {
    test('return Restaurant list if the http call completes successfully',
        () async {
      final client = MockClient();
      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response(
              '{ "error": false, "message": "msg", "count": 20, "restaurants": [ { "id": "idResto", "name": "restoName", "description": "desc", "pictureId": "picId", "city": "restoCity", "rating": 4.2 } ] }',
              200));
      expect(
          await ApiService().restaurantList(client), isA<RestaurantResult>());
    });
  });
}
