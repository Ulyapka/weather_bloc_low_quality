import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_clean_arch/bloc/weather_bloc.dart';
import 'package:weather_clean_arch/bloc/weather_event.dart';
import 'package:weather_clean_arch/bloc/weather_state.dart';

late String globalCityName;

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherBloc _weatherBloc = BlocProvider.of<WeatherBloc>(context);
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
                  globalCityName = value;
                },
              ),
            ),
            TextButton(
              child: const Text('Click Me!'),
              onPressed: () {
                _weatherBloc.add(WeatherLoadEvent());
              },
            ),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoadedState) {
                  return Center(
                    child: Text(
                      '${state.loadedWeather.list?[0].temp?.day}',
                      style: const TextStyle(fontSize: 50.0),
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
