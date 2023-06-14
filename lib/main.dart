import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  Map<String, dynamic>? weatherData;

  @override
  void initState() {
    super.initState();
    fetchWeatherData('Paris'); // Initialize with the default city
  }

  Future<void> fetchWeatherData(String city) async {
    final url = 'https://weatherapi-com.p.rapidapi.com/current.json?q=$city';

    final response = await http.get(Uri.parse(url), headers: {
      'X-RapidAPI-Key': '4963d60031msh3d70877a80409e2p136230jsn47500fce3554',
    });

    if (response.statusCode == 200) {
      setState(() {
        weatherData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  Widget buildWeatherForecast() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          weatherData!['location']['name'],
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          '${weatherData!['current']['temp_c'].toInt()}°C',
          style: const TextStyle(fontSize: 48),
        ),
        Text(
          weatherData!['current']['condition']['text'],
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        const Text(
          'Prochaines heures',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        // ignore: avoid_unnecessary_containers
        Container(
          child: SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return const Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          '14:00',
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(Icons.wb_sunny),
                        Text(
                          '27°C',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Temps des jours à venir',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        const Text(
          'Lever et coucher de soleil',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
        ),
        body: weatherData == null
            ? const Center(child: CircularProgressIndicator())
            : buildWeatherForecast(),
        bottomNavigationBar: BottomAppBar(
          child: SizedBox(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    // Actions when the user presses the "Home" button
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    // Actions when the user presses the "Settings" button
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}