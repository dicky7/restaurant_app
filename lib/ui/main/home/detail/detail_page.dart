import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_data.dart';
import 'package:restaurant_app/widget/body_detail.dart';

class DetailPage extends StatelessWidget{
  static const rootName = "/detail_page";
  final RestaurantElement restaurant;

  const DetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: BodyDetail(restaurant: restaurant),
      )
    );
  }



}