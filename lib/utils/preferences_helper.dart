import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const schedule = 'SCHEDULE';

  Future<bool> get isSchedule async {
    final prefs = await sharedPreferences;
    return prefs.getBool(schedule) ?? false;
  }

  void setSchedule(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(schedule, value);
  }
}
