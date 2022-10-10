import 'dart:convert';


RestaurantData restaurantListFromJson(String str) => RestaurantData.fromJson(json.decode(str));
String restaurantDataToJson(RestaurantData data) => json.encode(data.toJson());

class RestaurantData {
  RestaurantData({
    required this.error,
    this.message,
    this.count,
    this.founded,
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


class RestaurantDetails {
  RestaurantDetails({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  bool error;
  String message;
  Restaurant restaurant;

  factory RestaurantDetails.fromJson(Map<String, dynamic> json) => RestaurantDetails(
    error: json["error"],
    message: json["message"],
    restaurant: Restaurant.fromJsonDetail(json["restaurant"]),
  );
}

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.customerReviews,
  });

  String? id;
  String? name;
  String? description;
  String? city;
  String? address;
  String? pictureId;
  List<Category>? categories;
  Menus? menus;
  double? rating;
  List<CustomerReview>? customerReviews;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    city: json["city"],
    pictureId: json["pictureId"],
    rating: json["rating"].toDouble(),
  );


  factory Restaurant.fromJsonDetail(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    city: json["city"],
    address: json["address"],
    pictureId: json["pictureId"],
    categories: List<Category>.from(
        json["categories"].map((x) => Category.fromJson(x))),
    menus: Menus.fromJson(json["menus"]),
    rating: json["rating"].toDouble(),
    customerReviews: List<CustomerReview>.from(
        json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
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


class Category {
  Category({
    this.name,
  });

  String? name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json["name"],
  );
}

class CustomerReview {
  CustomerReview({
    this.name,
    this.review,
    this.date,
  });

  String? name;
  String? review;
  String? date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
    name: json["name"],
    review: json["review"],
    date: json["date"],
  );
}

class Menus {
  Menus({
    this.foods,
    this.drinks,
  });

  List<Category>? foods;
  List<Category>? drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
    foods: List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
    drinks: List<Category>.from(json["drinks"].map((x) => Category.fromJson(x))),
  );
}
