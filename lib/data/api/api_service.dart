import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant_data.dart';
import 'package:restaurant_app/data/model/restaurant_details.dart';

class ApiService{
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";
  static const String _restaurantList = "/list";
  static const String _restaurantDetail = "/detail/";
  static const String _restaurantSearch = "/search?q=";
  static const String _restaurantAddReview = "/review";
  static const String _smallImageUrl = "/images/small/";
  static const String _mediumImageUrl = "/images/medium/";

  Future<RestaurantData> restaurantList() async{
    final response = await http.get(Uri.parse("$_baseUrl$_restaurantList"));
    if(response.statusCode == 200){
      return RestaurantData.fromJson(json.decode(response.body));
    }else{
      throw Exception("Failed to load restaurant list");
    }
  }

  Future<RestaurantDetails> restaurantDetails(String id) async{
    final response = await http.get(Uri.parse("$_baseUrl$_restaurantDetail$id"));
    if(response.statusCode == 200){
      return RestaurantDetails.fromJson(json.decode(response.body));
    }else{
      throw Exception("Failed to load Detail restaurant");
    }
  }

  Future<RestaurantData> restaurantSearch(String query) async{
    final response = await http.get(Uri.parse("$_baseUrl$_restaurantSearch$query"));
    if(response.statusCode == 200){
      return RestaurantData.fromJson(json.decode(response.body));
    }else{
      throw Exception("Failed to search restaurant");
    }
  }

  smallImage(pictureId){
    String url = "$_baseUrl$_smallImageUrl$pictureId";
    return url;
  }
  mediumImage(pictureId){
    String url = "$_baseUrl$_mediumImageUrl$pictureId";
    return url;
  }


}