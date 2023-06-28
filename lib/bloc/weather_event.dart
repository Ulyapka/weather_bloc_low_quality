abstract class WeatherEvent {}

class WeatherLoadEvent extends WeatherEvent {
  final String? cityName;

  WeatherLoadEvent({required this.cityName});
}
