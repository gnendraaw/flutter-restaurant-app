import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/retaurant_detail';

  final String id;

  const DetailPage({Key? key, required this.id}) : super(key: key);

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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Consumer<FavoriteProvider>(
              builder: (context, provider, child) {
                return FutureBuilder(
                  future: provider.isFavorited(id),
                  builder: (context, snapshot) {
                    var isFavorited = snapshot.data ?? false;
                    return isFavorited
                        ? const Icon(Icons.favorite)
                        : Container();
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: ChangeNotifierProvider<RestaurantDetailProvider>(
        create: (_) =>
            RestaurantDetailProvider(apiService: ApiService(), id: id),
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
