import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';
import 'package:restaurant_app/providers/database_provider.dart';
import 'package:restaurant_app/providers/preferences_provider.dart';
import 'package:restaurant_app/providers/restaurant_providers.dart';
import 'package:restaurant_app/providers/scheduling_providers.dart';
import 'package:restaurant_app/ui/main/home/addReview/add_review_page.dart';
import 'package:restaurant_app/ui/main/home/detail/detail_page.dart';
import 'package:restaurant_app/ui/main/main_page.dart';
import 'package:restaurant_app/ui/onBoarding/login_page.dart';
import 'package:restaurant_app/ui/onBoarding/on_boarding_page.dart';
import 'package:restaurant_app/ui/onBoarding/splash_screen.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if(Platform.isAndroid){
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ListRestaurantProviders>(
          create: (context) => ListRestaurantProviders(
              apiService: ApiService()
          )
        ),
        ChangeNotifierProvider<DetailRestaurantProvider>(
          create: (context) => DetailRestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<SearchRestaurantProviders>(
          create: (context) => SearchRestaurantProviders(
              apiService: ApiService()
          ),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider<AddReviewProvider>(
          create: (context) => AddReviewProvider(
            apiService: ApiService()
          ),
        ),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (context) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance()
            )
          ),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (context) => DatabaseProvider(
            databaseHelper: DatabaseHelper()
          ),
        )
      ],

      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            navigatorKey: navigatorKey,
            theme: provider.themeData,
            initialRoute: SplashScreen.rootName,
            routes: {
              SplashScreen.rootName: (context) => const SplashScreen(),
              OnBoarding.routName: (context) => const OnBoarding(),
              LoginPage.rootName: (context) => const LoginPage(),
              MainPage.rootName: (context) => const MainPage(),
              AddReviewPage.rootName: (context) => AddReviewPage(
                restaurantId: ModalRoute.of(context)?.settings.arguments as String,
              ),
              DetailPage.rootName: (context) => DetailPage(
                restaurantId: ModalRoute.of(context)?.settings.arguments as String,
              ),
            },
          );
        },
      ),
    );
  }
}

