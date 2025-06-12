import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/widgets/custom_text.dart';
import '../provider/weather_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isLoading = false;

  Future<void> _searchCity(String value) async {
    setState(() {
      isLoading = true;
    });

    await Provider.of<WeatherProvider>(
      context,
      listen: false,
    ).getWeather(cityName: value);

    setState(() {
      isLoading = false;
    });

    if (context.mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CustomText(text: "Search a City")),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  onSubmitted: _searchCity,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 32,
                      horizontal: 24,
                    ),
                    label: const CustomText(text: "Search"),
                    border: const OutlineInputBorder(),
                    hintText: "Enter City",
                  ),
                ),
              ),
      ),
    );
  }
}
