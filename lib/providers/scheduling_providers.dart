import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier{
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduleRestaurant(bool value) async{
    _isScheduled = value;
    if(_isScheduled){
      print("Scheduling Restaurant Actived");
      notifyListeners();
      return await AndroidAlarmManager.periodic(
          const Duration(hours: 24),
          1,
          BackgroundService.callback,
          //if scheduling not show make sure date format use ('y/m/d') not ('y/M/d')
          startAt: DateTimeHelper.format(),
          exact: true,
          wakeup: true
      );
    }else{
      print("Scheduling Restaurant Cancel");
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}