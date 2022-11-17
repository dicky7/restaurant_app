import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/providers/restaurant_providers.dart';
import 'package:restaurant_app/ui/main/main_page.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widget/card_restaurant_item.dart';


class RestaurantCityPage extends StatelessWidget{
  static const rootName = "/restaurant_city";
  final String city;
  const RestaurantCityPage({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 18),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(context),
              const SizedBox(height: 25),
              Flexible(child: _buildListRestaurant(context, city: city))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: CircleAvatar(
            backgroundColor: Colors.blueGrey,
            child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigation.intentWithDataClearTop(MainPage.rootName);
                }),
          ),
        ),
        SizedBox(width: 25,),
        Flexible(
          flex: 4,
          child: Text("Restaurant in $city",
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }

  Widget _buildListRestaurant(BuildContext context,{required String city}) {
    return Consumer<ListRestaurantProviders>(
      builder: (context, state, _) {
        if(state.state == ResultState.loading){
          return Center(
            child: Lottie.asset("images/logo.json", width: 250, height: 250),
          );
        }else if (state.state == ResultState.hasData){
          var restaurant = state.result.restaurants.where((element) => element.city?.toLowerCase() == city.toLowerCase()).toList();
          return ListView.builder(
            shrinkWrap: true,
            itemCount: restaurant.length,
            itemBuilder: (context, index) {
              return CardRestaurantItem(restaurant: restaurant[index]);
            },
          );
        }else if(state.state == ResultState.noData){
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        }else if(state.state == ResultState.error){
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        }else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
      },
    );
  }

}