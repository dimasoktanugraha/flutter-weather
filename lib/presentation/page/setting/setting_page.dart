import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/theme/theme_bloc.dart';
import 'bloc/unit/unit_bloc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            BlocBuilder<UnitBloc, UnitState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  units: (isCelcius){
                    return ListTile(
                      leading: const Icon(Icons.thermostat_rounded),
                      title: Text((isCelcius) ? "Celcius" : "Fahrenheit"),
                      trailing: Switch(
                        value: isCelcius,
                        onChanged: (value) => context.read<UnitBloc>().add(const UnitEvent.toogleUnit())),
                    );
                  }
                );
              },
            ),
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  theme: (isDark){
                    return ListTile(
                      leading: const Icon(Icons.dark_mode),
                      title: Text((isDark) ? "Dark Theme" : "Light Theme"),
                      trailing: Switch(
                        value: isDark,
                        onChanged: (value) => context.read<ThemeBloc>().add(const ThemeEvent.toogleTheme())),
                    );
                  }
                );
              },
            )
          ],
        ),
    );
  }
}
