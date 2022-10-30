import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/retaurant_detail';

  final Restaurant restaurant;

  const DetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Restaurant Details',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Consumer<FavoriteProvider>(
            builder: (context, provider, child) {
              return FutureBuilder(
                future: provider.isFavorited(restaurant.id),
                builder: (context, snapshot) {
                  var isFavorite = snapshot.data ?? false;
                  if (isFavorite) {
                    return IconButton(
                      onPressed: () {
                        provider.removeFavorite(restaurant.id);
                      },
                      icon: const Icon(Icons.favorite),
                    );
                  } else {
                    return IconButton(
                      onPressed: () {
                        provider.addFavorite(restaurant);
                      },
                      icon: const Icon(Icons.favorite_border),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
      body: ChangeNotifierProvider<RestaurantDetailProvider>(
        create: (_) => RestaurantDetailProvider(
            apiService: ApiService(), id: restaurant.id),
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                  child: CircularProgressIndicator(color: secondaryColor));
            } else if (state.state == ResultState.hasData) {
              return RestaurantDetailPage(
                  restaurant: state.restaurantList.restaurant);
            } else if (state.state == ResultState.noData) {
              return const Center(child: Text('we found nothing'));
            } else if (state.state == ResultState.error) {
              return const Center(child: Text('something went wrong'));
            } else {
              return const Center();
            }
          },
        ),
      ),
    );
  }
}
