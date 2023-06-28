import 'dart:convert';

import 'package:weather_clean_arch/models/weather_forecast_daily.dart';
import 'package:weather_clean_arch/screens/test_screen.dart';
import 'package:weather_clean_arch/utilities/constants.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  Future<WeatherForecast> fetchWeatherForecast() async {
    Map<String, String>? parameters;

    var queryParameters = {
      'APPID': Constants.WEATHER_APP_ID,
      'units': 'metric',
      'q': globalCityName,
    };
    parameters = queryParameters.cast<String, String>();

    var uri = Uri.https(Constants.WEATHER_BASE_URL_DOMAIN,
        Constants.WEATHER_FORECAST_PATH, parameters);

    var response = await http.get(uri);
    print(response.body);

    if (response.statusCode == 200) {
      return WeatherForecast.fromJson(json.decode(response.body));
    } else {
      return Future.error('Error response');
    }
  }
}
