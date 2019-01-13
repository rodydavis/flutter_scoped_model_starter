import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';

import '../../../constants.dart';
import '../../../utils/date_formatter.dart';
//https://hk.saowen.com/a/93b1afca128ec54ab022b3c05203df69f414efde30cda1ec1a30164c385b55aa

class CurrentWeatherCard extends StatefulWidget {
  @override
  CurrentWeatherCardState createState() {
    return new CurrentWeatherCardState();
  }
}

class CurrentWeatherCardState extends State<CurrentWeatherCard> {
  bool isLoading = false;
  WeatherData weatherData;
  ForecastData forecastData;
  Location _location = new Location();
  String error;

  @override
  void initState() {
    super.initState();

    loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _tablet = _size.width > kTabletBreakpoint;
    print("Width: ${_size.width}, Heigth: ${_size.height}");
    return Card(
      color: Colors.blueGrey,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 14.0),
              child: weatherData != null ? Weather(weather: weatherData) : null,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: isLoading
                  ? CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: new AlwaysStoppedAnimation(Colors.white),
                    )
                  : IconButton(
                      icon: new Icon(Icons.refresh),
                      tooltip: 'Refresh',
                      onPressed: loadWeather,
                      color: Colors.white,
                    ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: _tablet ? 160.0 : 200,
//                height: 180.0,
                  child: forecastData != null
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: forecastData.list.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => WeatherItem(
                                weather: forecastData.list.elementAt(index),
                              ),
                        )
                      : Container(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  loadWeather() async {
    setState(() {
      isLoading = true;
    });

    Map<String, double> location;

    try {
      location = await _location.getLocation();

      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - please ask the user to enable it from the app settings';
      }

      location = null;
    }

    if (location != null) {
      final lat = location['latitude'];
      final lon = location['longitude'];

      final weatherResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/weather?APPID=0721392c0ba0af8c410aa9394defa29e&lat=${lat.toString()}&lon=${lon.toString()}');
      print(
          'https://api.openweathermap.org/data/2.5/weather?APPID=0721392c0ba0af8c410aa9394defa29e&lat=${lat.toString()}&lon=${lon.toString()}');
      final forecastResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/forecast?APPID=0721392c0ba0af8c410aa9394defa29e&lat=${lat.toString()}&lon=${lon.toString()}');

      if (weatherResponse.statusCode == 200 &&
          forecastResponse.statusCode == 200) {
        return setState(() {
          weatherData =
              new WeatherData.fromJson(jsonDecode(weatherResponse.body));
          forecastData =
              new ForecastData.fromJson(jsonDecode(forecastResponse.body));
          isLoading = false;
        });
      }
    }

    setState(() {
      isLoading = false;
    });
  }
}

class Weather extends StatelessWidget {
  final WeatherData weather;

  Weather({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(weather.name, style: new TextStyle(color: Colors.white)),
        Text(weather.main,
            style: new TextStyle(color: Colors.white, fontSize: 32.0)),
        Text('${weather.temp.toString()}°F',
            style: new TextStyle(color: Colors.white)),
        Image.network('https://openweathermap.org/img/w/${weather.icon}.png'),
//        Text(
//          new DateFormat.yMMMd().format(weather.date),
//          style: new TextStyle(color: Colors.white),
//        ),
        Text(
          formatDateCustom(DateTime.now(), format: "EEE, MMM d, yyyy"),
          style: new TextStyle(color: Colors.white),
        ),
        Text(
          new DateFormat.jm().format(weather.date),
          style: new TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

class WeatherItem extends StatelessWidget {
  final WeatherData weather;

  WeatherItem({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(weather.name, style: new TextStyle(color: Colors.black)),
            Text(weather.main,
                style: new TextStyle(color: Colors.black, fontSize: 24.0)),
            Text('${weather.temp.toString()}°F',
                style: new TextStyle(color: Colors.black)),
            Image.network(
                'https://openweathermap.org/img/w/${weather.icon}.png'),
            Text(
              new DateFormat.yMMMd().format(weather.date),
              style: new TextStyle(color: Colors.black),
            ),
            Text(
              new DateFormat.jm().format(weather.date),
              style: new TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class ForecastData {
  final List list;

  ForecastData({this.list});

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    List list = new List();

    for (dynamic e in json['list']) {
      WeatherData w = new WeatherData(
          date: new DateTime.fromMillisecondsSinceEpoch(e['dt'] * 1000,
              isUtc: false),
          name: json['city']['name'],
          temp: _kelvinToFarienhight(e['main']['temp'].toDouble()),
          main: e['weather'][0]['main'],
          icon: e['weather'][0]['icon']);
      list.add(w);
    }

    return ForecastData(
      list: list,
    );
  }
}

double _kelvinToFarienhight(double value) {
  var _result = (value - 273.15) * 9 / 5 + 32;
  return _result.roundToDouble();
}

class WeatherData {
  final DateTime date;
  final String name;
  final double temp;
  final String main;
  final String icon;

  WeatherData({this.date, this.name, this.temp, this.main, this.icon});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      date: new DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000,
          isUtc: false),
      name: json['name'],
      temp: _kelvinToFarienhight(json['main']['temp'].toDouble()),
      main: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
    );
  }
}
