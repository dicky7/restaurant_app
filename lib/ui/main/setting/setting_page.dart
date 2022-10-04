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
      appBar: AppBar(
        title: const Text("Settings"),
        automaticallyImplyLeading: false,

      ),
      body: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          child: buildList(context)
      )
    );
  }

  Widget buildList(BuildContext context) {
    return ListView(
      children: [
        Material(
          child: ListTile(
            title: Text(
              "Dark Theme",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w400),
            ),
            trailing: Switch.adaptive(
                value: false,
                onChanged: (value) {

                },
            ),
          ),
        ),
        Material(
          child: ListTile(
            title: Text(
              "Logout",
              style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.w400),
            ),
            trailing: GestureDetector(
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
                        Navigator.pushReplacementNamed(context, SplashScreen.rootName);
                        logout();
                      },
                          child: const Text("Yes", style: TextStyle(color: Colors.indigo))
                      )
                    ],
                  );
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                child: const Icon(
                  Icons.logout,
                  size: 25,
                ),
              ),
            ),
          ),
        )
      ],
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