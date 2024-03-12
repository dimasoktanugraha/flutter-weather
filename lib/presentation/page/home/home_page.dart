import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/data/model/foreacast_model.dart';
import 'package:weather/data/model/weather_model.dart';
import 'package:weather/presentation/extension/unit_ext.dart';
import 'package:weather/presentation/page/home/bloc/foreacast/forecast_bloc.dart';
import 'package:weather/presentation/page/home/bloc/weather/weather_bloc.dart';

import '../../../data/cache/cache_helper_key.dart';
import '../../components/weather_icon.dart';
import '../../widgets/address_item.dart';
import '../../widgets/forecast_item.dart';
import '../../widgets/weather_item.dart';
import '../setting/bloc/theme/theme_bloc.dart';
import '../setting/bloc/unit/unit_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "", address = "";

  @override
  void initState() {
    checkGps();
    super.initState();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();

    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      long = position.longitude.toString();
      lat = position.latitude.toString();
    });

    context.read<WeatherBloc>().add(
        WeatherEvent.getWeather(position.latitude, position.longitude));
    context.read<ForecastBloc>().add(
        ForecastEvent.getForecast(position.latitude, position.longitude));

    placemarkFromCoordinates(position.latitude, position.longitude)
    .then((placemarks) {
      var output = 'No results found.';
      if (placemarks.isNotEmpty) {
        output = placemarks[0].subAdministrativeArea.toString();
      }

      setState(() {
        address = output;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<UnitBloc, UnitState>(
        builder: (context, state) {
          return state.maybeWhen(
              orElse: () => const SizedBox.shrink(),
              units: (isCelcius) => ListView(
                  children: [
                    addressItem(long, lat, address),
                    BlocBuilder<WeatherBloc, WeatherState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                            orElse: () => const Center(
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: CircularProgressIndicator(),
                                )
                            ),
                            loading: () => const Center(
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: CircularProgressIndicator(),
                                )
                            ),
                            loaded: (weather){
                              return weatherItem(weather, isCelcius);
                            },
                            error: (message){
                              return Text(
                                "error: $message",
                                style: const TextStyle(fontSize: 16),
                              );
                            }
                        );
                      },
                    ),
                    SizedBox(height: 50,),
                    BlocBuilder<ForecastBloc, ForecastState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                            orElse: () => const SizedBox.shrink(),
                            loading: () => const Center(
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: CircularProgressIndicator(),
                                )
                            ),
                            loaded: (forecast){
                              return forecastItem(forecast, isCelcius);
                            },
                            error: (message){
                              return Text(
                                "error: $message",
                                style: const TextStyle(fontSize: 16),
                              );
                            }
                        );
                      },
                    ),
                  ]
              )
          );
        }
      )
    );
  }
}

String getTemperature(double temp, String unit, bool isCelcius) {
    if (unit == WeatherUnits.imperial.name && isCelcius){
      return '${temp.fahrenheitToCelcius} °C';
    }else if (unit == WeatherUnits.metric.name && !isCelcius){
      return '${temp.celciusToFahrenheit} °F';
    }else if (unit == WeatherUnits.metric.name && isCelcius){
      return '${temp} °C';
    }else{
      return '${temp} °F';
    }
}
