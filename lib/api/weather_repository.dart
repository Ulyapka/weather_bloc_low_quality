// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:weather_clean_arch/api/weather_api.dart';

class WeatherRepository {
  WeatherApi getWeatherApi() {
    return WeatherApi();
  }
}
