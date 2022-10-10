import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant_data.dart';

class ApiService{
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";
  static const String _restaurantList = "/list";
  static const String _restaurantDetail = "/detail/";
  static const String _restaurantSearch = "/search?q=";
  static const String _restaurantAddReview = "/review";
  static const String _smallImageUrl = "/images/small/";
  static const String _mediumImageUrl = "/images/medium/";
  static const String _headers = "application/x-www-form-urlencoded";

  Future<RestaurantData> restaurantList(http.Client client) async{
    final response = await client.get(Uri.parse("$_baseUrl$_restaurantList"));
    if(response.statusCode == 200){
      return RestaurantData.fromJson(json.decode(response.body));
    }else{
      throw Exception("Failed to load restaurant list");
    }
  }

  Future<RestaurantDetails> restaurantDetails(http.Client client, String id) async{
    final response = await client.get(Uri.parse("$_baseUrl$_restaurantDetail$id"));
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

  Future<bool> addReview({required String id, required String name, required String review}) async{
    final response = await http.post(
      Uri.parse("$_baseUrl$_restaurantAddReview"),
      headers: {"Content-Type": _headers},
      body: {"id" : id, "name" : name, "review" : review }
    );
    if(response.statusCode == 201){
      return true;
    }else{
      throw Exception('Failed to post review!');
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