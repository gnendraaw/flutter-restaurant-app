import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/retaurant_detail';

  final String id;

  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(
        apiService: ApiService(),
        id: id,
      ),
      child: Consumer<RestaurantDetailProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            var restaurant = state.restaurantList.restaurant;
            return Scaffold(
              appBar: AppBar(
                title: Text(restaurant.name),
              ),
              body: RestaurantDetailPage(restaurant: restaurant),
            );
          } else {
            return const Center(child: Text(''));
          }
        },
      ),
    );
  }
}

class RestaurantDetailPage extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(
            'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
            fit: BoxFit.fitWidth,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(restaurant.name),
              Text(restaurant.city),
              Text(
                restaurant.description,
                maxLines: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
