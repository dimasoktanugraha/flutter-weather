import 'package:flutter/material.dart';

import '../../data/model/foreacast_model.dart';
import '../components/weather_icon.dart';
import '../page/home/home_page.dart';

Widget forecastItem(List<ForecastModel> forecast, bool isCelcius) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: forecast.map((data) {
      return Expanded(
          child: Column(
            children: [
              Text(
                  data.day!
              ),
              const SizedBox(height: 8),
              WeatherIcon(iconUrl: data.iconUrl, size: 50),
              const SizedBox(height: 8),
              Text(getTemperature(data.temp, data.unit, isCelcius)),
              SizedBox(
                height: 50,
                child: Text(
                  data.description,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )
      );
    }).toList(),
  );
}