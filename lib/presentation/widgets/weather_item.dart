import 'package:flutter/material.dart';
import 'package:weather/data/model/weather_model.dart';
import '../components/weather_icon.dart';
import '../page/home/home_page.dart';

Widget weatherItem(WeatherModel weather, bool isCelcius) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            WeatherIcon(iconUrl: weather.iconUrl, size: 180),
            Text(
              weather.description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)
            ),
          ],
        ),
        const SizedBox(width: 20,),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
                getTemperature(weather.temp, weather.unit, isCelcius),
                style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w600)
            ),
            const SizedBox(height: 10,),
            Text('High : ${
                getTemperature(weather.tempMax, weather.unit, isCelcius)}',
                style: const TextStyle(fontSize: 16)
            ),
            Text('Low : ${
                getTemperature(weather.tempMin, weather.unit, isCelcius)}',
                style: const TextStyle(fontSize: 16)
            ),
            Text(
                'Humidity : ${weather.humidity}%',
                style: const TextStyle(fontSize: 16)),
            Text(
                'Wind : ${weather.speed} km/h',
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ],
    ),
  );;
}