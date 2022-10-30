import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/widgets/custom_dialog.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';

  const SettingsPage({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<SchedulingProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            ListTile(
              title: const Text('Daily recommended restaurant'),
              subtitle: const Text(
                  'get yourself a daily recommended restaurant notification'),
              trailing: Switch.adaptive(
                value: provider.isScheduled,
                onChanged: (value) async {
                  if (Platform.isIOS) {
                    customDialog(context);
                  } else {
                    provider.enableSchedule(value);
                    // provider.enableSchedule(value);
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildAndroid(context);
  }
}
