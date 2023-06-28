import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_clean_arch/bloc/weather_bloc.dart';
import 'package:weather_clean_arch/bloc/weather_event.dart';
import 'package:weather_clean_arch/bloc/weather_state.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String? cityName;

  @override
  Widget build(BuildContext context) {
    final WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                cursorColor: Colors.blueGrey[800],
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Введите название города',
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black54,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(7.0),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  icon: Icon(
                    Icons.location_city,
                    color: Colors.black54,
                    size: 50.0,
                  ),
                ),
                onChanged: (value) {
                  cityName = value;
                  weatherBloc.add(WeatherLoadEvent(cityName: cityName));
                },
              ),
            ),
            /* TextButton(
              child: const Text('Click Me!'),
              onPressed: () {
                weatherBloc.add(WeatherLoadEvent(cityName: cityName));
              },
            ),*/
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoadedState) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          cityName!.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${state.loadedWeather.list?[0].temp?.day?.ceil()}ºC'
                              .toUpperCase(),
                          style: const TextStyle(
                            fontSize: 50.0,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          '${state.loadedWeather.list?[0].weather![0].description}'
                              .toUpperCase(),
                          style: const TextStyle(
                            fontSize: 40.0,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if (state is WeatherLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is WeatherErrorState) {
                  return const Center(
                    child: Text(
                        'Ошибочка вышла =(\nНаверное вы не ввели название города\nили оно введено неверно...'),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
