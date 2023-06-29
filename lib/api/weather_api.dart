import 'dart:convert';
import 'dart:developer';

import 'package:weather_clean_arch/models/weather_forecast_daily.dart';
import 'package:weather_clean_arch/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:weather_clean_arch/utilities/location.dart';

class WeatherApi {
  Future<WeatherForecast> fetchWeatherForecast(String cityName) async {
    Map<String, String>? parameters;

    Location location = Location();
    await location.getCurrentLocation();

    if (cityName != '') {
      var queryParameters = {
        'APPID': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'q': cityName,
        'lang': 'RU'
      };
      parameters = queryParameters.cast<String, String>();
    } else {
      var queryParameters = {
        'APPID': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
        'lang': 'RU'
      };
      parameters = queryParameters;
    }

    var uri = Uri.https(Constants.WEATHER_BASE_URL_DOMAIN,
        Constants.WEATHER_FORECAST_PATH, parameters);

    var response = await http.get(uri);
    log(response.body);

    if (response.statusCode == 200) {
      return WeatherForecast.fromJson(json.decode(response.body));
    } else {
      return Future.error('Error response');
    }
  }
}
