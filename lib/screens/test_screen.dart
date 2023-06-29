import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_clean_arch/bloc/weather_bloc.dart';
import 'package:weather_clean_arch/bloc/weather_event.dart';
import 'package:weather_clean_arch/bloc/weather_state.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(WeatherLoadEvent(cityName: ''));
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                cursorColor: Colors.blueGrey[800],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w300,
                ),
                decoration: const InputDecoration(
                  hintText: 'Введите название города',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w300,
                  ),
                  filled: true,
                  fillColor: Colors.black54,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(7.0),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  icon: Icon(
                    Icons.search_outlined,
                    color: Colors.black54,
                    size: 50.0,
                  ),
                ),
                onChanged: (value) {
                  weatherBloc.add(WeatherLoadEvent(cityName: value));
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
                          '${state.loadedWeather.city?.name}',
                          style: const TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.w300,
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
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.center,
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
