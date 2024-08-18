import 'package:sky_watch/services/location.dart';
import 'package:sky_watch/services/networking.dart';




const apiKey='apikey';
const openWeatherMapUrl ='https://api.openweathermap.org/data/2.5/weather';



class WeatherModel {

  Future<dynamic> getCityWeather(String cityName)async{
    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=metric');
    var weatherData= await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather()async {
    Location location = Location();
    await location.getCurrentPosition();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapUrl?lat=${location.latitude}&lon=${location
            .longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();

    return weatherData;

  }
    Future<dynamic> getDayWeather()async{
    Location location = Location();
    await location.getCurrentPosition();
    NetworkHelper networkHelper = NetworkHelper('https://pro.openweathermap.org/data/2.5/forecast/hourly?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
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

  String getMessage(String Icon) {
    if (Icon =='🤷') {
      return 'It\'s 🍦 time';
    } else if (Icon =='☀️') {
      return 'Time for shorts and 👕';
    } else if (Icon == '☃️') {
      return 'You\'ll need 🧣 and 🧤';
    } else if(Icon=='☁️' || Icon =='🌩') {
      return 'Bring a 🧥 just in case';
    }else if(Icon=='☔️'||Icon=='🌧'){
      return 'You\'ll need an Umbrella';
    }else{
      return 'All is Good';
    }
  }
}
