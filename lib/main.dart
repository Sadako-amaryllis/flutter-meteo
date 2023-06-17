import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  Map<String, dynamic>? weatherData;

  @override
  void initState() {
    super.initState();
    fetchWeatherData('Paris'); // Initialize with the default city (Paris)
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
    final currentCondition = weatherData!['current']['condition']['text'];
    String weatherImage = 'assets/images/Sun.svg';

    if (currentCondition.contains('cloud')) {
      weatherImage = 'assets/images/Clouds.svg';
    } else if (currentCondition.contains('fog')) {
      weatherImage = 'assets/images/Fog.svg';
    } else if (currentCondition.contains('moon')) {
      weatherImage = 'assets/images/Moon.svg';
    } else if (currentCondition.contains('night')) {
      weatherImage = 'assets/images/NightCloud.svg';
    } else if (currentCondition.contains('rain')) {
      weatherImage = 'assets/images/Rain.svg';
    } else if (currentCondition.contains('snow')) {
      weatherImage = 'assets/images/Snow.svg';
    } else if (currentCondition.contains('storm')) {
      weatherImage = 'assets/images/Storm.svg';
    } else if (currentCondition.contains('sun')) {
      weatherImage = 'assets/images/Sun&Clouds.svg';
    } else if (currentCondition.contains('wind')) {
      weatherImage = 'assets/images/Wind.svg';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          weatherData!['location']['name'],
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          '${weatherData!['current']['temp_c'].toInt()}°C',
          style: TextStyle(fontSize: 48),
        ),
        SizedBox(height: 10),
        SvgPicture.asset(
          weatherImage,
          height: 100,
          width: 100,
        ),
        SizedBox(height: 10),
        Text(
          currentCondition,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 20),
        Text(
          'Prochaines heures',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, index) {
              return Card(
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
        SizedBox(height: 20),
        Text(
          'Temps des jours à venir',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text(
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
          title: Text('Weather App'),
        ),
        body: weatherData == null
            ? Center(child: CircularProgressIndicator())
            : buildWeatherForecast(),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    // Actions when the user presses the "Home" button
                  },
                ),
                IconButton(
                  icon: Icon(Icons.settings),
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
