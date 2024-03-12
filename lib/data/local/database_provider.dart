import 'package:sqflite/sqflite.dart';
import 'package:weather/data/model/foreacast_model.dart';

import '../model/weather_model.dart';

class DatabaseProvider{

  static DatabaseProvider? _databaseProvider;

  DatabaseProvider._instance() {
    _databaseProvider = this;
  }

  factory DatabaseProvider() => _databaseProvider ?? DatabaseProvider._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }
  
  final String dbName = 'weather.db';
  final String weatherTableName = 'weather';
  final String forecastTableName = 'forecast';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/$dbName';

    var db = await openDatabase(
      databasePath, 
      version: 1, 
      onCreate: _onCreate
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $weatherTableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        iconUrl TEXT, 
        description TEXT, 
        temp REAL, 
        tempMax REAL, 
        tempMin REAL, 
        unit TEXT,
        humidity INTEGER, 
        speed REAL,
        createdAt INTEGER);
    ''');
    await db.execute('''
      CREATE TABLE $forecastTableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        iconUrl TEXT, 
        description TEXT, 
        day TEXT, 
        temp REAL, 
        unit TEXT,
        createdAt INTEGER);
    ''');
  }

  Future<int> insertWeather(WeatherModel weather) async {
    final db = await database;
    return await db!.insert(weatherTableName, weather.toMap());
  }

  Future<WeatherModel> getWeather() async {

    final db = await database;
    List<Map<String, dynamic>> results = 
      await db!.query(
        weatherTableName,
        limit: 1
      );
    if(results.isEmpty){
      return WeatherModel(
          iconUrl: "",
          description: "",
          temp: 0.0,
          tempMax: 0.0,
          tempMin: 0.0,
          unit: "",
          humidity: 0,
          speed: 0.0,
          createdAt: DateTime.now());
    }
    return results.map((res) => WeatherModel.fromMap(res)).first;
  }

  Future<void> deleteWeather() async {
    final db = await database;
  
    await db!.rawDelete("DELETE FROM $weatherTableName");
  }


  Future<int> insertForecast(List<ForecastModel> forecasts) async {
    final db = await database;
    final batch = db!.batch();

    for (ForecastModel data in forecasts) {
      batch.insert(forecastTableName, data.toMap());
    }

    final List<dynamic> result = await batch.commit();
    final int affectedRows = result.reduce((sum, element) => sum + element);
    return affectedRows;
  }

  Future<List<ForecastModel>> getForecastList() async {
    final db = await database;

    List<Map<String, dynamic>> results = 
      await db!.query(
        forecastTableName,
      );

    return List.generate(results.length, (i) {
      return ForecastModel.fromMap(results[i]);
    });
  }

  Future<void> deleteForecasts() async {
    final db = await database;
  
    await db!.rawDelete("DELETE FROM $forecastTableName");
  }


}