import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/restaurant_providers.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widget/body_detail.dart';
import 'package:lottie/lottie.dart';

class DetailPage extends StatefulWidget{
  static const rootName = "/detail_page";
  final String restaurantId;

  const DetailPage({Key? key,
    required this.restaurantId
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<DetailRestaurantProvider>(
          context,
          listen: false
      ).fetchDetailRestaurant(widget.restaurantId);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<DetailRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return Center(
                child: Lottie.asset("images/logo.json", width: 250, height: 250),
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
        ),
      ),
    );
  }
}