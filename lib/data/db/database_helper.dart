import 'package:restaurant_app/data/model/restaurant_data.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tableBookmark = "bookkmarks";

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/bookmarks_db.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tableBookmark (
           id TEXT PRIMARY KEY,
          name TEXT,
          description TEXT,
          pictureId TEXT,
          city TEXT,
          rating DOUBLE
         )     
      ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async{
    if(_database == null){
      _database = await _initializeDb();
    }
    return _database;
  }

  Future<void> insertBookmark(Restaurant restaurant) async{
    final db = await database;
    await db!.insert(_tableBookmark, restaurant.toJson());
  }

  Future<List<Restaurant>> getBookmarks() async{
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tableBookmark);
    return results.map((e) => Restaurant.fromJson(e)).toList();
  }

  Future<Map> getBookmarkById(String id) async{
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
        _tableBookmark,
        where: "id = ?",
        whereArgs: [id]
    );

    if(results.isNotEmpty){
      return results.first;
    }else{
      return{};
    }
  }

  Future<void> removeBookmarkById(String id) async{
    final db = await database;
    await db!.delete(
      _tableBookmark,
      where: "id = ?",
      whereArgs: [id]
    );
  }

  Future<void> removeAllBookmark() async{
    final db = await database;
    await db!.delete(_tableBookmark);
  }


}