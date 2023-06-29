// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:weather_clean_arch/api/weather_api.dart';
import 'package:weather_clean_arch/models/weather_forecast_daily.dart';

class WeatherRepository {
  final WeatherDataSource _weatherDataSource;

  WeatherRepository(this._weatherDataSource);

  Future<WeatherForecast> getWeather(cityName) {
    return _weatherDataSource.fetchWeatherForecast(cityName);
  }
}
