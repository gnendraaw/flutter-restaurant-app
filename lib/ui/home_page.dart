import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/provider/restaurants_provider.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    super.initState();
    getConnectivity();
  }

  getConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() => isAlertSet = true);
        }
      });

  showDialogBox() {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('No connection'),
        content: const Text('please check your internet connectivity'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context, 'Cancel');
              setState(() => isAlertSet = false);
              isDeviceConnected =
                  await InternetConnectionChecker().hasConnection;
              if (!isDeviceConnected) {
                showDialogBox();
                setState(() => isAlertSet = true);
              }
            },
            child: const Text(
              'Ok',
              style: TextStyle(color: secondaryColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurantss'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              if (isDeviceConnected) {
                showSearch(
                  context: context,
                  delegate: SearchPage(),
                );
              }
            },
          ),
        ],
      ),
      body: ChangeNotifierProvider<RestaurantsProvider>(
        create: (_) => RestaurantsProvider(apiService: ApiService()),
        child: const RestaurantListPage(),
      ),
    );
  }
}
