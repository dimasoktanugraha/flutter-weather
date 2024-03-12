// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ForecastModel {

  final int? id;
  final String iconUrl;
  final String description;
  final String day;
  final double temp;
  final String unit;
  final DateTime createdAt;

  ForecastModel({
    this.id, 
    required this.iconUrl, 
    required this.description, 
    required this.day, 
    required this.temp,
    required this.unit,
    required this.createdAt
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'iconUrl': iconUrl,
      'description': description,
      'day': day,
      'temp': temp,
      'unit': unit,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory ForecastModel.fromMap(Map<String, dynamic> map) {
    return ForecastModel(
      id: map['id'] != null ? map['id'] as int : null,
      iconUrl: map['iconUrl'] as String,
      description: map['description'] as String,
      day: map['day'] as String,
      temp: map['temp'] as double,
      unit: map['unit'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ForecastModel.fromJson(String source) => ForecastModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
