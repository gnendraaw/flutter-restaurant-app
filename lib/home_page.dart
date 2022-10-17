import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/detail_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Restaurant',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Looking for something?',
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  suffixIcon: const Icon(Icons.search),
                  focusColor: Colors.grey,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: RestaurantList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RestaurantList extends StatelessWidget {
  const RestaurantList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          final List<Restaurant> restaurants = parseRestaurant(snapshot.data);
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return _buildListItem(context, restaurants, index);
            },
          );
        });
  }

  GestureDetector _buildListItem(
      BuildContext context, List<Restaurant> restaurants, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName,
            arguments: restaurants[index]);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Hero(
                    tag: restaurants[index].id,
                    child: Image.network(
                      restaurants[index].pictureId,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fitHeight,
                    )),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurants[index].name,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(restaurants[index].city,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                        )),
                    Text(restaurants[index].rating.toString(),
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
