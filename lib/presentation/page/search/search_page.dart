import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/presentation/page/search/bloc/search/search_bloc.dart';

import '../../../common/colors.dart';
import '../../../data/cache/cache_helper_key.dart';
import '../../../data/cache/shared_prefs.dart';
import '../../components/search_input.dart';
import '../../components/weather_icon.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: SearchInput(
              controller: _searchController,
              onPressed: () {
                FocusScope.of(context).unfocus();
                context.read<SearchBloc>().add(SearchEvent.searchWeather(_searchController.text));
              },
              onSubmitted: (value){
                context.read<SearchBloc>().add(SearchEvent.searchWeather(value));
              }
            ),
          ),
          const SizedBox(height: 50,),
          BlocBuilder<SearchBloc, SearchState>(
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
                loaded: (weather){
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${weather.weather![0].description!}°',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20)
                      ),
                      WeatherIcon(iconUrl: weather.weather![0].iconUrl ?? "", size: 160),
                      Text(
                        '${weather.main!.temp!}° ${SharedPrefs().unit == WeatherUnits.metric.name ? 'C' : 'F'}',
                          style: const TextStyle(fontSize: 40)
                      ),
                      Text('High : ${weather.main!.tempMax!} Low : ${weather.main!.tempMin!}',
                          style: const TextStyle(fontSize: 20)
                      ),
                      Text('Humidity : ${weather.main!.humidity!} %',
                          style: const TextStyle(fontSize: 20)
                      ),
                      Text('Wind Speed : ${weather.wind!.speed!} km/h',
                          style: const TextStyle(fontSize: 20)
                      ),
                    ],
                  );
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
        ],
      )
    );
  }
}