import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';
import 'package:restaurant_app/widgets/restaurant_search_card.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';

class SearchPage extends SearchDelegate {
  dynamic result;
  late Future<RestaurantSearchResult> _restaurantResult;

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
    return ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (_) =>
          RestaurantSearchProvider(apiService: ApiService(), query: query),
      child: Consumer<RestaurantSearchProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(
                child: CircularProgressIndicator(color: secondaryColor));
          } else if (state.state == ResultState.noData) {
            return const Center(
                child: Text('Nothing found, try another keyword'));
          } else if (state.state == ResultState.hasData) {
            final restaurants = state.restaurantResult.restaurants;
            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return RestaurantCard(restaurant: restaurants[index]);
              },
            );
          } else if (state.state == ResultState.error) {
            return const Center(child: Text('Something went wrong'));
          } else {
            return const Center();
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      _restaurantResult = ApiService().restaurantSearch(query);
      return _buildSearchList();
    }
    return const Center(child: Text("Let's find something"));
  }

  FutureBuilder<RestaurantSearchResult> _buildSearchList() {
    return FutureBuilder(
      future: _restaurantResult,
      builder: (context, snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return const Center(
              child: CircularProgressIndicator(color: secondaryColor));
        } else {
          if (snapshot.hasData) {
            int? founded = snapshot.data?.founded;
            if (founded! <= 0) {
              return const Center(
                  child: Text('Nothing found, try another keyword'));
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data?.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = snapshot.data?.restaurants[index];
                return RestaurantCard(
                  restaurant: restaurant!,
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          } else {
            return const Center();
          }
        }
      },
    );
  }
}
