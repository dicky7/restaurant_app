
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier{
  PreferencesHelper preferencesHelper;
  PreferencesProvider({required this.preferencesHelper}){
    getUsername();
    getDailyReminder();
    getTheme();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isDailyReminder = false;
  bool get isDailyReminder => _isDailyReminder;

  String _isUsername = "";
  String get isUsername => _isUsername;


  //apply theme
  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  void getTheme() async{
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }
  void enableDarkTheme(bool value){
    preferencesHelper.setDarkTheme(value);
    getTheme();
  }

  void getDailyReminder() async{
    _isDailyReminder = await preferencesHelper.isDailyReminderActive;
    notifyListeners();
  }
  void enableDailyReminder(bool value){
    preferencesHelper.setDailyReminder(value);
    getDailyReminder();
  }

  void getUsername() async{
    _isUsername = await preferencesHelper.isUsername;
    notifyListeners();
  }
  void setUsername(String username){
    preferencesHelper.setUsername(username);
    getUsername();
  }
  void removeUsername(){
    preferencesHelper.removeUsername();
    getUsername();
  }

}