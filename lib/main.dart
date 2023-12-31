import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_clean_arch/api/weather_api.dart';
import 'package:weather_clean_arch/api/weather_repository.dart';
import 'package:weather_clean_arch/bloc/weather_bloc.dart';
import 'package:weather_clean_arch/screens/test_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => WeatherBloc(
            weatherRepository: WeatherRepository(WeatherDataSource())),
        child: const TestScreen(),
      ),
    );
  }
}
