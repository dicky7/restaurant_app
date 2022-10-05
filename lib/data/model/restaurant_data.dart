import 'dart:convert';

// To parse this JSON data, do
//     final restaurantList = restaurantListFromJson(jsonString);

import 'dart:convert';

RestaurantData restaurantListFromJson(String str) => RestaurantData.fromJson(json.decode(str));
String restaurantDataToJson(RestaurantData data) => json.encode(data.toJson());

class RestaurantData {
  RestaurantData({
    required this.error,
    required this.message,
    required this.count,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  String? message;
  int? count;
  int? founded;
  List<Restaurant> restaurants;

  factory RestaurantData.fromJson(Map<String, dynamic> json) => RestaurantData(
    error: json["error"],
    message: json["message"],
    count: json["count"],
    founded: json["founded"],
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "count": count,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };

}

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    pictureId: json["pictureId"],
    city: json["city"],
    rating: json["rating"].toDouble(),
  );
  
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "pictureId": pictureId,
    "city": city,
    "rating": rating,
  };
}
