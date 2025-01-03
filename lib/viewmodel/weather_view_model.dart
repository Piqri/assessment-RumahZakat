import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherFactory _weatherFactory;
  Weather? currentWeather;
  List<Weather> forecastWeather = [];
  Map<String, List<Weather>> groupedForecast = {};
  bool isLoading = true;

  WeatherViewModel(String apiKey) : _weatherFactory = WeatherFactory(apiKey);

  Future<void> fetchWeather(String city) async {
    isLoading = true;
    notifyListeners();
    try {
      Weather weatherNow = await _weatherFactory.currentWeatherByCityName(city);
      List<Weather> forecast =
          await _weatherFactory.fiveDayForecastByCityName(city);

      currentWeather = weatherNow;
      forecastWeather = forecast;
      groupedForecast = _groupForecastByDay(forecast);
    } catch (e) {
      print("Error fetching weather data: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Map<String, List<Weather>> _groupForecastByDay(List<Weather> forecast) {
    Map<String, List<Weather>> grouped = {};
    for (var weather in forecast) {
      String day = DateFormat("EEEE, d MMMM yyyy").format(weather.date!);
      if (!grouped.containsKey(day)) {
        grouped[day] = [];
      }
      grouped[day]!.add(weather);
    }
    return grouped;
  }
}
