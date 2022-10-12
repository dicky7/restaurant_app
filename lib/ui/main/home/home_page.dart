import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/preferences_provider.dart';
import 'package:restaurant_app/widget/body_home.dart';

class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return Scaffold(
            body: SafeArea(
              child: Container(
                child: BodyHome(name: provider.isUsername),
              ),

            )
        );
      },
    );
  }
}
