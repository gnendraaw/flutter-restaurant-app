import 'package:flutter/material.dart';
import 'package:restaurant_app/provider/restaurants_provider.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurantss'),
      ),
      body: ChangeNotifierProvider<RestaurantsProvider>(
        create: (_) => RestaurantsProvider(apiService: ApiService()),
        child: const RestaurantListPage(),
      ),
    );
  }
}
