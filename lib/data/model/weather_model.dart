// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherModel {

  final int? id;
  final String iconUrl;
  final String description;
  final double temp;
  final double tempMax;
  final double tempMin;
  final String unit;
  final int humidity;
  final double speed;
  final DateTime createdAt;

  WeatherModel({
    this.id, 
    required this.iconUrl, 
    required this.description, 
    required this.temp, 
    required this.tempMax, 
    required this.tempMin, 
    required this.unit, 
    required this.humidity, 
    required this.speed, 
    required this.createdAt
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'iconUrl': iconUrl,
      'description': description,
      'temp': temp,
      'tempMax': tempMax,
      'tempMin': tempMin,
      'unit': unit,
      'humidity': humidity,
      'speed': speed,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      id: map['id'] != null ? map['id'] as int : null,
      iconUrl: map['iconUrl'] as String,
      description: map['description'] as String,
      temp: map['temp'] as double,
      tempMax: map['tempMax'] as double,
      tempMin: map['tempMin'] as double,
      unit: map['unit'] as String,
      humidity: map['humidity'] as int,
      speed: map['speed'] as double,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) => WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

}
