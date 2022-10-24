import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
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
      ),
      body: ChangeNotifierProvider<RestaurantDetailProvider>(
        create: (_) =>
            RestaurantDetailProvider(apiService: ApiService(), id: id),
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                  child: CircularProgressIndicator(color: primaryTextColor));
            } else if (state.state == ResultState.hasData) {
              var restaurant = state.restaurantList.restaurant;
              return RestaurantDetailPage(restaurant: restaurant);
            } else if (state.state == ResultState.noData) {
              return const Center(child: Text('We found nothing..'));
            } else if (state.state == ResultState.error) {
              return const Center(
                  child: Text('Oops! something went wrong, try again later'));
            } else {
              return const Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}
