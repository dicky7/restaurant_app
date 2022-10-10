import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/preferences_provider.dart';
import 'package:restaurant_app/widget/body_home.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return Scaffold(
            body: SafeArea(
              child: Container(
                color: Theme.of(context).backgroundColor,
                child: BodyHome(name: provider.isUsername),
              ),

            )
        );
      },
    );
  }
}
