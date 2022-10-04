import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/providers/restaurant_providers.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widget/body_detail.dart';

class DetailPage extends StatelessWidget{
  static const rootName = "/detail_page";
  final String restaurantId;

  const DetailPage({Key? key,
    required this.restaurantId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<DetailRestaurantProvider>(
        context,
        listen: false
    ).fetchDetailRestaurant(restaurantId);

    return Consumer<DetailRestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.hasData) {
          return BodyDetail(restaurant: state.result.restaurant);
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
      }
    );
  }




}