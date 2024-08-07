import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sky_watch/screens/location_screen.dart';
import 'package:sky_watch/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';




class LoadingScreen extends StatefulWidget {



  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {



  @override
  void initState() {
    super.initState();
    getPermission();
    getLocationData();

  }

  void getPermission() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
  }

  void getLocationData()async {

    var weatherData = await WeatherModel().getLocationWeather();
    Navigator.push(context,MaterialPageRoute(builder: (context){
     return LocationScreen(weatherData);
   }));

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      )
    );
  }
}
