import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/database_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widget/card_restaurant_item.dart';

class FavoritePage extends StatelessWidget{
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTittle(context),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              "Favorite Restaurant",
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.2),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
              onPressed: () {
                Provider.of<DatabaseProvider>(context, listen: false).removeAllBookmark();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListRestaurant() {
    return Consumer<DatabaseProvider>(
      builder: (context, providers, _) {
        if (providers.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: providers.bookmarks.length,
            itemBuilder: (context, index) {
              var restaurant = providers.bookmarks[index];
              return CardRestaurantItem(restaurant: restaurant);
            },
          );
        } else if (providers.state == ResultState.noData) {
          return Center(
            child: Text(
              "Restaurant Not Found",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w700,
                  height: 1.2),
            ),
          );
        } else if (providers.state == ResultState.error) {
          return Center(
            child: Text(providers.message),
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