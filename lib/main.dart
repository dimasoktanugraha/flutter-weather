import 'package:flutter/material.dart';
import 'package:weather/common/theme.dart';
import 'package:weather/presentation/page/home/bloc/foreacast/forecast_bloc.dart';
import 'package:weather/presentation/page/home/bloc/weather/weather_bloc.dart';
import 'package:weather/presentation/page/search/bloc/search/search_bloc.dart';
import 'package:weather/presentation/page/setting/bloc/theme/theme_bloc.dart';
import 'package:weather/presentation/page/setting/bloc/unit/unit_bloc.dart';

import 'data/cache/shared_prefs.dart';
import 'presentation/route/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di/locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    final router = appRouter.router;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.locator<ThemeBloc>()),
        BlocProvider(create: (context) => di.locator<UnitBloc>()),
        BlocProvider(create: (context) => di.locator<WeatherBloc>()),
        BlocProvider(create: (context) => di.locator<ForecastBloc>()),
        BlocProvider(create: (context) => di.locator<SearchBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            theme: (isDark) => MaterialApp.router(
              title: 'Weather',
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
              routerDelegate: router.routerDelegate,
              routeInformationParser: router.routeInformationParser,
              routeInformationProvider: router.routeInformationProvider,
            )
          );
        },
      ),
    );
  }
}
