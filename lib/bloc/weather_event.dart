abstract class WeatherEvent {}

class WeatherLoadEvent extends WeatherEvent {
  final String? cityName;

  WeatherLoadEvent({required String this.cityName});
}
