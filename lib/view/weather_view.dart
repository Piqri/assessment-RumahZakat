import 'package:assesment/config/const.dart';
import 'package:assesment/viewmodel/weather_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:assesment/view/widget/widget.dart';

class WeatherView extends StatelessWidget {
  final String name;
  final String city;
  final String province;

  const WeatherView({
    super.key,
    required this.name,
    required this.city,
    required this.province,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherViewModel(OPENWEATHER_API_KEY)..fetchWeather(city),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  "https://i.pinimg.com/736x/27/72/f6/2772f6d855ac350b64f11544aa7640bf.jpg"),
            ),
          ),
          child: Consumer<WeatherViewModel>(
            builder: (context, viewModel, _) {
              if (viewModel.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (viewModel.currentWeather == null ||
                  viewModel.forecastWeather.isEmpty) {
                return const Center(child: Text("Failed to load weather data"));
              }

              return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    nameUser(name),
                    weatherHeader(
                      viewModel.currentWeather!.temperature!.celsius!
                          .toStringAsFixed(0),
                      viewModel.currentWeather!.weatherDescription.toString(),
                      city,
                      province,
                    ),
                    weatherIcon(
                        viewModel.currentWeather!.weatherIcon.toString()),
                    Container(
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 150,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          weatherInfo(
                              "Wind",
                              viewModel.currentWeather!.windSpeed!
                                  .toStringAsFixed(1),
                              "m/s",
                              Icons.air),
                          weatherInfo(
                              "Humidity",
                              viewModel.currentWeather!.humidity.toString(),
                              "%",
                              Icons.water),
                          weatherInfo(
                              "Pressure",
                              viewModel.currentWeather!.pressure.toString(),
                              "hPa",
                              Icons.cloud),
                          weatherInfo(
                              "Visibility",
                              viewModel.currentWeather!.cloudiness.toString(),
                              "%",
                              Icons.visibility),
                        ],
                      ),
                    ),
                    const Text(
                      "Next 5 days forecast",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    forecastWeatherInfo(viewModel.groupedForecast),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
