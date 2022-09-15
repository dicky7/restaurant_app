import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/onBoarding/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget{
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Log Out",
                    style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          title: const Text("Logout"),
                          content: const Text("Are your sure want logout? you may lose your data"),
                          actions: [
                            TextButton(onPressed: () {
                              Navigator.pop(context);
                            },
                              child: const Text("No", style: TextStyle(color: Colors.red))
                            ),
                            TextButton(onPressed: () {
                              Navigator.pushNamed(context, SplashScreen.rootName);
                              logout();
                            },
                                child: const Text("Yes", style: TextStyle(color: Colors.indigo))
                            )
                          ],
                        );
                      });
                    },
                    child: const Icon(
                      Icons.logout,
                      size: 35,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove("username");
      prefs.remove("loginState");
    });
  }
}