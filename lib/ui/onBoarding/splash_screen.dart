import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/ui/main/home/home_page.dart';
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
  var _state;
  late Timer _timer;

  @override
  void initState() {
    getState();
    _timer = Timer(const Duration(seconds: 5), () {
      if(_state == true){
        Navigation.intentWithDataClearTop(MainPage.rootName);
      }
      else{
        Navigation.intentWithDataClearTop(OnBoarding.routName);
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
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
  }


  getState() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _state = prefs.getBool("loginState");
    });
  }

  @override
  void dispose() {
    _timer;
    super.dispose();
  }
}