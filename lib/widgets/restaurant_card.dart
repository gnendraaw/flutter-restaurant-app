import 'package:flutter/material.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:provider/provider.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigation.intentWithData(DetailPage.routeName, restaurant.id),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: primaryColor,
          boxShadow: [
            BoxShadow(blurRadius: 1, color: defaultShadow.withOpacity(0.5)),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/default-food-img.png');
                    },
                    width: 100,
                    height: 100,
                    fit: BoxFit.fitHeight,
                  )),
            ),
            const SizedBox(width: 24),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      overflow: TextOverflow.ellipsis,
                      color: primaryTextColor,
                    ),
                  ),
                  Text(
                    restaurant.city,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: fadeTextColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      Text(restaurant.rating.toString()),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              child: Consumer<FavoriteProvider>(
                builder: (context, provider, child) {
                  return FutureBuilder(
                    future: provider.isFavorited(restaurant.id),
                    builder: (context, snapshot) {
                      var isFavorited = snapshot.data ?? false;
                      return isFavorited
                          ? IconButton(
                              onPressed: () {
                                provider.removeFavorite(restaurant.id);
                              },
                              icon: const Icon(Icons.favorite),
                            )
                          : IconButton(
                              onPressed: () {
                                provider.addFavorite(restaurant);
                              },
                              icon: const Icon(Icons.favorite_border),
                            );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
