import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/data/model/restaurant_data.dart';


class DatabaseProvider extends ChangeNotifier{
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}){
    _getBookmarks();
  }

  ResultState? _state;
  String _message = "";

  ResultState? get state => _state;
  String get message => _message;

  List<Restaurant> _bookmarks = [];
  List<Restaurant> get bookmarks => _bookmarks;

  void _getBookmarks() async{
    _bookmarks = await databaseHelper.getBookmarks();
    if(_bookmarks.isNotEmpty){
      _state = ResultState.hasData;
    }else{
      _state = ResultState.noData;
      _message = "Empty Data";
    }
    notifyListeners();
  }

  void addBookmarks(Restaurant restaurant) async{
    try{
      await databaseHelper.insertBookmark(restaurant);
      _getBookmarks();
    }catch(e){
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isBookmarked(String id) async{
    final bookmarked = await databaseHelper.getBookmarkById(id);
    return bookmarked.isNotEmpty;
  }

  void removeBookmarkById(String id) async{
    try{
      await databaseHelper.removeBookmarkById(id);
      _getBookmarks();
    }catch(e){
      _state = ResultState.error;
      _message = "Error $e";
      notifyListeners();
    }
  }

  void removeAllBookmark() async{
    try{
      await databaseHelper.removeAllBookmark();
      _getBookmarks();
    }catch(e){
      _state = ResultState.error;
      _message = "Error $e";
      notifyListeners();
    }
  }
}