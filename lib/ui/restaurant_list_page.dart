import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/provider/restaurants_provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/widgets/restaurant_card.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantsProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
              child: CircularProgressIndicator(color: secondaryColor));
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: state.restaurantResult.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.restaurantResult.restaurants[index];
              return RestaurantCard(restaurant: restaurant);
            },
          );
        } else {
          return const Center(
              child: Material(
            child: Text(''),
          ));
        }
      },
    );
  }
}
