import 'package:weather_clean_arch/models/weather_forecast_daily.dart';

abstract class WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  WeatherForecast loadedWeather;
  WeatherLoadedState({
    required this.loadedWeather,
  });
}

class WeatherErrorState extends WeatherState {}
