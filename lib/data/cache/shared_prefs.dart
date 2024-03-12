import 'package:shared_preferences/shared_preferences.dart';

import 'cache_helper_key.dart';

class SharedPrefs {
  static late SharedPreferences _sharedPrefs;

  static final SharedPrefs _instance = SharedPrefs._internal();

  factory SharedPrefs() => _instance;

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  String get unit => _sharedPrefs.getString(CacheHelperKey.unit.name) ?? WeatherUnits.metric.name;

  void setUnit(WeatherUnits unit) {
    _sharedPrefs.setString(CacheHelperKey.unit.name, unit.name);
    print("Saved : ${unit.name}");
  }

  bool get theme => _sharedPrefs.getBool(CacheHelperKey.theme.name) ?? false;

  void setTheme(bool isDark) {
    _sharedPrefs.setBool(CacheHelperKey.theme.name, isDark);
    print("Saved : ${isDark}");
  }
}