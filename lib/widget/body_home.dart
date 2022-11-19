import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/model/restaurant_data.dart';
import 'package:restaurant_app/providers/restaurant_providers.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widget/card_restaurant_item.dart';
import 'package:restaurant_app/ui/main/home/city/restaurant_city.dart';

class BodyHome extends StatelessWidget {
  final String name;

  const BodyHome({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _headerGreetings(context),
        const SizedBox(height: 15),
        Flexible(child: _buildListRestaurant(context)),
      ],
    );
  }

  Widget _headerGreetings(BuildContext context) {
    int hour = DateTime.now().hour;
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 24, right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        (hour >= 0 && hour < 12)
                            ? "Good Morning $name"
                            : (hour >= 12 && hour <= 18)
                                ? "Good Afternoon $name"
                                : "Good Night $name",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontWeight: FontWeight.w300)),
                  ),
                  Container(
                      child: (hour >= 0 && hour < 12)
                          ? const Icon(Icons.cloud,
                              size: 35, color: Colors.blue)
                          : (hour >= 12 && hour <= 18)
                              ? const Icon(Icons.sunny,
                                  size: 35, color: Colors.amber)
                              : const Icon(
                                  Icons.sunny_snowing,
                                  color: Colors.indigo,
                                  size: 35,
                                ))
                ],
              ),
              const SizedBox(height: 5),
              Text(
                "Lets Find Nearest Restaurant",
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildListRestaurant(BuildContext context) {
    return Consumer<ListRestaurantProviders>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return Center(
            child: Lottie.asset("images/logo.json", width: 250, height: 250),
          );
        } else if (state.state == ResultState.hasData) {
          return Column(
            children: [
              _buildCityRestaurant(context, label: "Cities", restaurant: state.result.restaurants),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.result.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurant = state.result.restaurants[index];
                    return CardRestaurantItem(restaurant: restaurant);
                  },
                ),
              )
            ],
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
      },
    );
  }

  Widget _buildCityRestaurant(BuildContext context, {required String label, required List<Restaurant> restaurant}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 14),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.w500)),
        ),
        Container(
            margin: const EdgeInsets.only(top: 10, left: 14),
            height: 34,
            color: Theme.of(context).cardTheme.color,
            child: ListView.builder(
              shrinkWrap: false,
              itemCount: restaurant.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigation.intentWithData(RestaurantCityPage.rootName,
                        arguments: restaurant[index].city);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).cardColor),
                    child: Center(
                      child: Text(restaurant[index].city!,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(fontWeight: FontWeight.w500)),
                    ),
                  ),
                );
              },
            )),
      ],
    );
  }
}
