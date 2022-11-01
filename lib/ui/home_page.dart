import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/favorite_page.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:restaurant_app/ui/settings_page.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

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

  int _bottomNavIndex = 0;

  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    getConnectivity();
    _notificationHelper
        .configureSelectNotificationSubject(DetailPage.routeName);
    super.initState();
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
      barrierDismissible: false,
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

  final List<Widget> _listWidget = [
    const RestaurantListPage(),
    const FavoritePage(),
    const SettingsPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.restaurant),
      label: 'Restaurants',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavBarItem,
        selectedItemColor: secondaryColor,
        currentIndex: _bottomNavIndex,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
