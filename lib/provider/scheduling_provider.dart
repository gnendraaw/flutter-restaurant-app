import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/date_time_helper.dart';
import 'package:restaurant_app/utils/preferences_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  final PreferencesHelper preferencesHelper;
  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  SchedulingProvider({required this.preferencesHelper}) {
    _getSchedule();
  }

  void _getSchedule() async {
    _isScheduled = await preferencesHelper.isSchedule;
    notifyListeners();
  }

  Future<bool> enableSchedule(bool value) async {
    _isScheduled = value;
    preferencesHelper.setSchedule(_isScheduled);
    if (isScheduled) {
      print('Scheduling resataurant activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('scheduling restaurant canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
