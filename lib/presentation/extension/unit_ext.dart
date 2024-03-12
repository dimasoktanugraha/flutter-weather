extension UnitExt on double {
  String get celciusToFahrenheit => ((this * 9 / 5) + 32).toStringAsFixed(2);
  String get fahrenheitToCelcius => ((this - 32) * 5 / 9).toStringAsFixed(2);
}
