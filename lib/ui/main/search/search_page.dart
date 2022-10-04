import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/utils.dart';
import 'package:restaurant_app/providers/restaurant_providers.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widget/card_restaurant_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTittle(context),
              const SizedBox(height: 20),
              _buildSearchField(context),
              const SizedBox(height: 15),
              Flexible(
                child: _buildListRestaurant(),
              )
            ],
          )
      ),
    );
  }

  Widget _buildTittle(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, right: 24, left: 24),
      child: Text(
        "Lets Find Nearest Restaurant",
        style: Theme.of(context).textTheme.headline4!.copyWith(
            fontWeight: FontWeight.w700,
            color: secondaryColor.withOpacity(0.8),
            height: 1.2),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: TextField(
        controller: _searchController,
        showCursor: true,
        decoration: InputDecoration(
            hintText: "Drinky Squash",
            isCollapsed: true,
            fillColor: Colors.grey.withOpacity(0.2),
            filled: true,
            contentPadding: const EdgeInsets.all(15),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey.shade500,
            ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            Provider.of<SearchRestaurantProviders>(context, listen: false)
                .fetchSearchingRestaurant(query: value);
          }else{
            Provider.of<SearchRestaurantProviders>(context,
                listen: false)
                .fetchSearchingRestaurant(query: "/");
          }
        },
      ),
    );
  }

  Widget _buildListRestaurant() {
    return Consumer<SearchRestaurantProviders>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return Center(
            child: Lottie.asset("images/logo.json", width: 250, height: 250),
          );
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: state.result!.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result!.restaurants[index];
              return CardRestaurantItem(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Text(
              "Restaurant Not Found",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: secondaryColor.withOpacity(0.5),
                  height: 1.2),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text(''),
          );
        }
      },
    );
  }

}
