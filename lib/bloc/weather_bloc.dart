import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_clean_arch/api/weather_repository.dart';
import 'package:weather_clean_arch/bloc/weather_event.dart';
import 'package:weather_clean_arch/bloc/weather_state.dart';
import 'package:weather_clean_arch/models/weather_forecast_daily.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository})
      : super(WeatherLoadingState()) {
    on<WeatherLoadEvent>((event, emit) async {
      emit(WeatherLoadingState());
      try {
        final WeatherForecast loadedWeather =
            await weatherRepository.getWeather(event.cityName ?? 'Moscow');
        emit(WeatherLoadedState(loadedWeather: loadedWeather));
      } catch (_) {
        emit(WeatherErrorState());
      }
    });
  }
}
