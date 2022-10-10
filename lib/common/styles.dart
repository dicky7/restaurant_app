import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFFFFFFF);
const Color secondaryColorLight = Color(0xffdcdcdc);
const Color backgroundColor = Color(0xfff8f9f0);

const Color darkPrimaryColor = Color(0xFF000000);
const Color secondaryColor = Color(0xff493b56);

ThemeData lightTheme = ThemeData(

    colorScheme: ThemeData.light().colorScheme.copyWith(
      primary: primaryColor,
      onPrimary: Colors.black,
      secondary: secondaryColorLight,
    ),
    textTheme: myTextTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: const AppBarTheme(elevation: 0),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: secondaryColorLight,
      unselectedItemColor: Colors.grey[300],
    ),
);

ThemeData darkTheme = ThemeData(
  
    colorScheme: ThemeData.dark().colorScheme.copyWith(
      primary: darkPrimaryColor,
      onPrimary: Colors.black,
      secondary: secondaryColor,
    ),
    textTheme: myTextTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: const AppBarTheme(elevation: 0),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkPrimaryColor,
      selectedItemColor: secondaryColor,
      unselectedItemColor: Colors.grey[600],
    ),
);

final TextTheme myTextTheme = TextTheme(
  headline4: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.poppins(fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
);