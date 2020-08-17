import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


const apikey = 'c55b78f27ee85226aa08ba798fbd10b1';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

//location

class Location{
  double latitude;
  double longitude;

  Future<void> getCurrentLocation() async {
    try {

      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    }
    catch(exception)
    {
      print(exception);
    }
  }
}



class NetworkHelper {

  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response response =  await http.get(url);

    if(response.statusCode == 200)
    {
      String data = response.body;
      return jsonDecode(data); //return dynamic
    }
    else {
      print(response.statusCode);
    }
  }
}


class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {

    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL?q=$cityName&appid=$apikey&units=metric');
    var weatherData  = await networkHelper.getData();
    return weatherData;

  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);


    NetworkHelper networkHelper =  NetworkHelper('$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey&units=metric');

    var weatherData  = await networkHelper.getData();
    return weatherData;

  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '☼';
    } else if (condition < 400) {
      return '☁️';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '☙';
    }
  }
}