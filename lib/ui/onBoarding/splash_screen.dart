import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/providers/preferences_provider.dart';
import 'package:restaurant_app/ui/main/main_page.dart';
import 'package:restaurant_app/ui/onBoarding/on_boarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget{
  static const rootName = "/splash_screen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 5), () {
      var prefsUsername = Provider.of<PreferencesProvider>(context, listen: false).isUsername;
      print("username"+prefsUsername);
      if(prefsUsername.isNotEmpty){
        Navigation.intentWithDataClearTop(MainPage.rootName);
      }
      else{
        Navigation.intentWithDataClearTop(OnBoarding.routName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Lottie.asset("images/logo.json"),
              ),
              Text(
                "Restaurant App",
                style: GoogleFonts.poppins(
                    fontSize: 28,
                    color: Colors.amber,
                    fontWeight: FontWeight.w600
                ),
              )
            ],
          ),
        ),
      ),
    );
    // return  Consumer<PreferencesProvider>(
    //   builder: (context, provider, child) {
    //     // print(provider.isUsername);
    //
    //   },
    // );
  }

  @override
  void dispose() {
    _timer;
    super.dispose();
  }
}