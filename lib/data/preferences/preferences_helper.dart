import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper{
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const darkTheme = 'DARK_THEME';

  Future<bool> get isDarkTheme async{
    final prefs = await sharedPreferences;
    return prefs.getBool(darkTheme) ?? false;
  }
  void setDarkTheme(bool value) async{
    final prefs = await sharedPreferences;
    prefs.setBool(darkTheme, value);
  }

  static const dailyReminder = 'DAILY_REMINDER';

  Future<bool> get isDailyReminderActive async{
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyReminder) ?? false;
  }
  void setDailyReminder(bool value) async{
    final prefs = await sharedPreferences;
    prefs.setBool(dailyReminder, value);
  }

  static const String username = "USERNAME";

  Future<String> get isUsername async{
    final prefs = await sharedPreferences;
    return prefs.getString(username) ?? "";
  }
  void setUsername(String value) async{
    final prefs = await sharedPreferences;
    prefs.setString(username, value);
  }
  void removeUsername() async{
    final prefs = await sharedPreferences;
    prefs.remove(username);
  }
}