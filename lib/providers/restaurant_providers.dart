import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_data.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:http/http.dart' as http;

class ListRestaurantProviders extends ChangeNotifier {
  final ApiService apiService;

  ListRestaurantProviders({required this.apiService}) {
    _fetchRestaurantList();
  }

  late RestaurantData _restaurantList;
  late ResultState _state;
  String _message = '';

  RestaurantData get result => _restaurantList;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> _fetchRestaurantList() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantList(http.Client());
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantList = restaurant;
      }
    } on TimeoutException catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Timeout $e";
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message = "No Internet Connection";
    } on Error catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Error $e";
    }
  }
}

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  DetailRestaurantProvider({required this.apiService});

  late RestaurantDetails _restaurantDetails;
  ResultState _state = ResultState.loading;
  String _message = "";

  RestaurantDetails get result => _restaurantDetails;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detail = await apiService.restaurantDetails(http.Client(),id);
      if (detail.restaurant.id == null) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetails = detail;
      }
    } on TimeoutException catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Timeout $e";
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message = "No Internet Connection";
    } on Error catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Error $e";
    }
  }
}

class SearchRestaurantProviders extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProviders({required this.apiService});

  RestaurantData? _restaurantSearch;
  ResultState? _state;
  String _message = "";

  RestaurantData? get result => _restaurantSearch;

  ResultState? get state => _state;

  String get message => _message;

  Future<dynamic> fetchSearchingRestaurant({String query = ""}) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantSearch(query);
      if (restaurant.founded == 0) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantSearch = restaurant;
      }
    } on TimeoutException catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Timeout $e";
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message = "No Internet Connection";
    } on Error catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Error $e";
    }
  }
}

class AddReviewProvider extends ChangeNotifier {
  final ApiService apiService;

  AddReviewProvider({required this.apiService});

  ResultStatePost? _state;
  String _message = "";

  ResultStatePost? get state => _state;
  String get message => _message;

  Future<dynamic> addReviewRestaurant(
      {required String id,
      required String name,
      required String review}) async {

    try{
      _state = ResultStatePost.loading;
      notifyListeners();
      final response = await apiService.addReview(id: id, name: name, review: review);
      if(response == true){
        _state = ResultStatePost.success;
        notifyListeners();
        return _message = "Success";
      }else{
        _state = ResultStatePost.error;
        notifyListeners();
        return _message = "Failed";
      }
    }on TimeoutException catch (e){
      _state = ResultStatePost.error;
      notifyListeners();
      return _message = "Timeout $e";
    }on SocketException catch (e){
      _state = ResultStatePost.error;
      notifyListeners();
      return _message = "No Internet Connection";
    }on Error catch(e){
      _state = ResultStatePost.error;
      notifyListeners();
      return _message = "Error $e";
    }
  }
}
