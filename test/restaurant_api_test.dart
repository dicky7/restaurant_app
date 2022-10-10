import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_data.dart';

void main(){
  group("Api Restaurant Test", () {
    test("Restauarant List", () async{
      final client = MockClient((request) async{
        final response = {
          "error": false,
          "message": "success",
          "count": 20,
          "restaurants": []
        };
        return Response(json.encode(response), 200);
      });
      expect(await ApiService().restaurantList(client), isA<RestaurantData>());

    });

    test("When restaurant detail is founded", () async{
      final client = MockClient((request) async{
        final response = {
          "error": false,
          "message": "success",
          "restaurant": {
            "id": "",
            "name": "",
            "description": "",
            "city": "",
            "address": "",
            "pictureId": "",
            "categories": [],
            "menus": {"foods": [], "drinks": []},
            "rating": 1.0,
            "customerReviews": []
          }
        };
        return Response(json.encode(response), 200);
      });
      expect(await ApiService().restaurantDetails(client, "mock id"), isA<RestaurantDetails>());
    });
  });
}