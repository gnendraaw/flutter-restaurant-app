import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

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
                child: FutureBuilder(
                    future: DefaultAssetBundle.of(context)
                        .loadString('assets/local_restaurant.json'),
                    builder: (context, snapshot) {
                      final List<Restaurant> restaurants =
                          parseRestaurant(snapshot.data);
                      return ListView.builder(
                        itemCount: restaurants.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Image.network(
                              restaurants[index].pictureId,
                            ),
                            title: Text(restaurants[index].name),
                            subtitle:
                                Text(restaurants[index].rating.toString()),
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
