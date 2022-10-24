import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/widgets/restaurant_search_card.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';

class SearchPage extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {},
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {},
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (_) =>
          RestaurantSearchProvider(apiService: ApiService(), query: query),
      child: Consumer<RestaurantSearchProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(
                child: CircularProgressIndicator(
              color: secondaryColor,
            ));
          } else if (state.state == ResultState.hasData) {
            if (state.restaurantResult.founded <= 0) {
              return const Center(
                  child: Text('Nothing found, try another keyword'));
            }

            final restaurants = state.restaurantResult.restaurants;
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return RestaurantCard(restaurant: restaurants[index]);
              },
            );
          } else {
            return const Center(child: Text('Oops! something went wrong'));
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text('Lets find something'));
  }
}
