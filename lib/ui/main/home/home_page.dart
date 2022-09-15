import 'package:flutter/material.dart';
import 'package:restaurant_app/widget/body_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var name;

  @override
  void initState() {
    getUsername();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            color: const Color(0xffededed),
            child: BodyHome(name: name),
          ),
        )
    );
  }
  getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    setState(() {
      String username = (prefs.getString('username') ?? "");
      name = username;
    });
  }
}
