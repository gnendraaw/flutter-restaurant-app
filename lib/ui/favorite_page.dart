import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/widgets/restaurant_card.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = '/favorite';

  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildAndroid(context);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return RestaurantCard(restaurant: provider.favorites[index]);
            },
          );
        },
      ),
    );
  }
}
