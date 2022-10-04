import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_data.dart';
import 'package:restaurant_app/data/model/restaurant_details.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:http/http.dart' as http;

class ListRestaurantProviders extends ChangeNotifier{
  final ApiService apiService;

  ListRestaurantProviders({required this.apiService}){
    _fetchRestaurantList();
  }

  late RestaurantData _restaurantList;
  late ResultState _state;
  String _message = '';

  RestaurantData get result => _restaurantList;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> _fetchRestaurantList() async{
    try{
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantList();
      if(restaurant.restaurants.isEmpty){
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Empty Data";

      }else{
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantList = restaurant;
      }

    }on TimeoutException catch(e){
      _state = ResultState.error;
      notifyListeners();
      return _message = "Timeout $e";

    }on SocketException catch(e){
      _state = ResultState.error;
      notifyListeners();
      return _message = "No Connection $e";

    }on Error catch(e){
      _state = ResultState.error;
      notifyListeners();
      return _message = "Error $e";
    }
  }
}

class DetailRestaurantProvider extends ChangeNotifier{
  final ApiService apiService;

  DetailRestaurantProvider({required this.apiService});

  late RestaurantDetails _restaurantDetails;
  late ResultState _state;
  String _message = "";

  RestaurantDetails get result => _restaurantDetails;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> fetchDetailRestaurant(String id) async{
    try{
      _state = ResultState.loading;
      notifyListeners();
      final detail = await apiService.restaurantDetails(id);
      if(detail.restaurant == null){
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Empty Data";
      }else{
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetails = detail;
      }

    }on TimeoutException catch(e){
      _state = ResultState.error;
      notifyListeners();
      return _message = "Timeout $e";
    }on SocketException catch(e){
      _state = ResultState.error;
      notifyListeners();
      return _message = "No Connection $e";
    }on Error catch(e){
      _state = ResultState.error;
      notifyListeners();
      return _message = "Error $e";
    }
  }
}

class SearchRestaurantProviders extends ChangeNotifier{
  final ApiService apiService;

  SearchRestaurantProviders({required this.apiService});

  RestaurantData? _restaurantSearch;
  ResultState? _state;
  String _message = "";

  RestaurantData? get result => _restaurantSearch;
  ResultState? get state => _state;
  String get message => _message;

  Future<dynamic> fetchSearchingRestaurant({String query = " "}) async{
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantSearch(query);
      if(restaurant.founded == 0){
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Empty Data";
      }else{
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantSearch = restaurant;
      }

    }on TimeoutException catch(e){
      _state = ResultState.error;
      notifyListeners();
      return _message = "Timeout $e";
    }on SocketException catch(e){
      _state = ResultState.error;
      notifyListeners();
      return _message = "No Connection $e";
    }on Error catch(e){
      _state = ResultState.error;
      notifyListeners();
      return _message = "Error $e";
    }
  }
}