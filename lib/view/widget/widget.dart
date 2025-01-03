import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

String getGreeting() {
  final hour = DateTime.now().hour;
  if (hour >= 5 && hour < 12) {
    return "Selamat pagi";
  } else if (hour >= 12 && hour < 17) {
    return "Selamat siang";
  } else if (hour >= 17 && hour < 19) {
    return "Selamat sore";
  } else {
    return "Selamat malam";
  }
}

Widget nameUser(String name) {
  return Text(
    "${getGreeting()}, $name",
    style: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}

Widget weatherHeader(
    String tempeture, String description, String city, String province) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$tempeture°C",
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            description.toString(),
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
      Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  city,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  province,
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
              ],
            ),
          ),
          Text(
            DateFormat("EEEE, d MMMM yyyy").format(DateTime.now()),
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    ],
  );
}

Widget weatherIcon(String icon) {
  return Container(
    height: 200,
    decoration: BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.fitWidth,
        image: NetworkImage(
          "http://openweathermap.org/img/wn/$icon@4x.png",
        ),
      ),
    ),
  );
}

Widget forecastWeatherInfo(Map<String, List<Weather>> groupedForecast) {
  return Column(
    children: groupedForecast.keys.map((day) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            day,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: groupedForecast[day]!.length,
              itemBuilder: (context, index) {
                Weather weather = groupedForecast[day]![index];
                return Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat("HH:mm").format(weather.date!),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Image.network(
                        "http://openweathermap.org/img/wn/${weather.weatherIcon}.png",
                        height: 50,
                        width: 50,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${weather.temperature!.celsius!.toStringAsFixed(0)}°C",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      );
    }).toList(),
  );
}

Widget weatherInfo(String title, String value, String unit, IconData icon) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        icon,
        color: Colors.white,
        size: 28,
      ),
      const SizedBox(height: 8),
      Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        "$value $unit",
        style: const TextStyle(fontSize: 14, color: Colors.white),
      ),
    ],
  );
}
