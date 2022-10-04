import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/utils.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_data.dart';
import 'package:restaurant_app/providers/restaurant_providers.dart';
import 'package:restaurant_app/ui/main/home/detail/detail_page.dart';
import 'package:restaurant_app/ui/main/main_page.dart';
import 'package:restaurant_app/ui/onBoarding/login_page.dart';
import 'package:restaurant_app/ui/onBoarding/on_boarding_page.dart';
import 'package:restaurant_app/ui/onBoarding/splash_screen.dart';

void main() {
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
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: primaryColor,
            onPrimary: Colors.black,
            secondary: secondaryColor,
          ),
          appBarTheme: const AppBarTheme(elevation: 0)
        ),
        initialRoute: SplashScreen.rootName,
        routes: {
          SplashScreen.rootName: (context) => const SplashScreen(),
          OnBoarding.routName: (context) => const OnBoarding(),
          LoginPage.rootName: (context) => const LoginPage(),
          MainPage.rootName: (context) => MainPage(),
          DetailPage.rootName: (context) => DetailPage(
            restaurantId: ModalRoute.of(context)?.settings.arguments as String,
          )
        },
      ),
    );
  }
}

