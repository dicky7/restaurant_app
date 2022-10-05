import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/model/restaurant_data.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper{
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();


  Future<void> initNotifications(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async{
    var initializationAndroid = const AndroidInitializationSettings("app_icon");
    var initializationIOS = const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    var initializationSettings = InitializationSettings(
      android: initializationAndroid,
      iOS: initializationIOS
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification:(payload) async{
        if(payload != null){
          print("notification payload$payload");
        }
        selectNotificationSubject.add(payload ?? "empty payload");
      },
    );
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, RestaurantData restaurantData) async{
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "restaurant app channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      ticker: "ticker",
      styleInformation: const DefaultStyleInformation(true,true)
    );

    var iOSPlatformSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformSpecifics
    );

    var tittleNotification = "<b> Restaurant Recommendation</b>";
    var tittleRestaurant = restaurantData.restaurants[0].name;

    await flutterLocalNotificationsPlugin.show(
    0, tittleNotification, tittleRestaurant, platformChannelSpecifics,
    payload: jsonEncode(restaurantData.toJson()));
  }

  void configureSelectNotificationSubject(String route){
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = RestaurantData.fromJson(json.decode(payload));
        var restaurant = data.restaurants[0];
        Navigation.intentWithData(route, arguments: restaurant.id);
      },
    );
  }


}