import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/widgets/restaurant_search_card.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';

class SearchPage extends SearchDelegate {
  dynamic result;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(
          context,
          result,
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text("Let's find something!"));
    }
    return ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (_) =>
          RestaurantSearchProvider(apiService: ApiService(), query: query),
      child: Consumer<RestaurantSearchProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(
                child: CircularProgressIndicator(color: secondaryColor));
          } else if (state.state == ResultState.noData) {
            return Center(child: Text(state.message));
          } else if (state.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: state.restaurantResult.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = state.restaurantResult.restaurants[index];
                return RestaurantCard(restaurant: restaurant);
              },
            );
          } else if (state.state == ResultState.error) {
            return Center(child: Text(state.message));
          } else {
            return const Center();
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text("Let's find something"));
  }
}
