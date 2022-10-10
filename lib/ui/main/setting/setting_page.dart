import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/preferences_provider.dart';
import 'package:restaurant_app/providers/scheduling_providers.dart';
import 'package:restaurant_app/widget/custom_dialog.dart';

class SettingPage extends StatefulWidget {
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
            child: buildList(context)));
  }

  Widget buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: Text(
                  "Dark Theme",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                trailing: Switch.adaptive(
                  value: provider.isDarkTheme,
                  onChanged: (value) {
                    provider.enableDarkTheme(value);
                  },
                ),
              ),
            ),
            Material(
              child: ListTile(
                title: Text(
                  "Scheduling Restaurant",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: provider.isDailyReminder,
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          customDialog(
                              context,
                              title: "Comming Soon!",
                              message: "This feature will be coming soon!");
                        } else {
                          scheduled.scheduleRestaurant(value);
                          provider.enableDailyReminder(value);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
            Material(
              child: ListTile(
                title: Text(
                  "Logout",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    provider.removeUsername();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
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
      },
    );
  }
}
