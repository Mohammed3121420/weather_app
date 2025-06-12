import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/get_weather_cubit_cubit.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/widgets/custom_text.dart';
import '../models/weather_model.dart';
import '../widgets/no_weather_body.dart';
import '../widgets/weather_info_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? weatherData;

  void updateUi() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => SearchPage(updateUi: updateUi),
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
        title: const CustomText(text: "Weather App"),
      ),
      body: BlocBuilder<GetWeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitial) {
            return const NoWeatherBody();
          } else if (state is WeatherLoadedState) {
            return WeatherInfoBody();
          } else {
            return const Text("oops there was  an error");
          }
        },
      ),
    );
  }
}
