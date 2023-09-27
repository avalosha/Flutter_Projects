import 'package:clima_flutter/services/location.dart';
import 'package:clima_flutter/services/networking.dart';

const String apiKey = '10a73642270eadcf5613439e70e6e36f';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper();
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
        {'q': cityName, 'appid': apiKey, 'units': 'metric'});

    var weatherData = await networkHelper.getData(url);
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper();
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'lat': '${location.latitude.toStringAsFixed(2)}',
      'lon': '${location.longitude.toStringAsFixed(2)}',
      'appid': apiKey,
      'units': 'metric'
    });
    var weatherData = await networkHelper.getData(url);
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
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
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
