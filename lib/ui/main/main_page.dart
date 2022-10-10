import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:restaurant_app/ui/main/favorite/favorite_page.dart';
import 'package:restaurant_app/ui/main/home/detail/detail_page.dart';
import 'package:restaurant_app/ui/main/home/home_page.dart';
import 'package:restaurant_app/ui/main/search/search_page.dart';
import 'package:restaurant_app/ui/main/setting/setting_page.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

class MainPage extends StatefulWidget{
  static const rootName = "/home_page";

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  int _selectedIndex = 0;

  final List<Widget> _listWidget = [
    const HomePage(),
    const SearchPage(),
    const FavoritePage(),
    const SettingPage(),
  ];

  final List<Color> tabColors = [
    Colors.amber,
    Colors.purpleAccent,
    Colors.pink,
    Colors.green
  ];

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
      DetailPage.rootName
    );
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_selectedIndex],

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1)
            )
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 13),
          child: GNav(
            activeColor: tabColors.elementAt(_selectedIndex),
            tabBackgroundColor: tabColors.elementAt(_selectedIndex).withOpacity(.1),
            iconSize: 24,
            duration: const Duration(milliseconds: 400),
            gap: 8,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: "Home",
              ),
              GButton(
                icon: Icons.search,
                text: "Search",
              ),
              GButton(
                icon: Icons.favorite_border,
                text: "Favorite",
              ),
              GButton(
                icon: Icons.settings,
                text: "Settings",
              )
            ],
            selectedIndex: _selectedIndex,
            onTabChange:(index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}