import 'package:flutter/material.dart';
import 'package:sky_watch/utilities/constants.dart';
import 'package:sky_watch/services/weather.dart';
import 'package:sky_watch/screens/city_screen.dart';


class LocationScreen extends StatefulWidget {
  LocationScreen(this.locationWeather);
  final _backImage= ('images/location_background.jpg');
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather =WeatherModel();


   late int temperature;
   String? weatherIcon;
   String? cityName;
   late String weatherMessage;
   num? windSpeed;
   num? visibility;
   String? description;
   num? humidity;
   int? pressure;



  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }
  void updateUI( dynamic weatherData){
    setState(() {
      if(weatherData == null){
       temperature =0;
       weatherIcon= 'Error';
       weatherMessage='Unable to get weather data';
       cityName='';
       return;
      }
        num temp = weatherData['main']['temp'];
        temperature = temp.toInt();
        var condition = weatherData['weather'][0]['id'];
        cityName = weatherData['name'];
        weatherIcon = weather.getWeatherIcon(condition);
        weatherMessage = weather.getMessage(weatherIcon!);
        windSpeed = weatherData['wind']['speed'];
        visibility =weatherData['visibility'];
        description= weatherData['weather'][0]['description'];
        humidity= weatherData['main']['humidity'];
        pressure= weatherData['main']['pressure'];


      });

}
  String getBackgroundImage() {
    if (weatherIcon == null) {
      return 'images/location_background.jpg';
    }
    switch (weatherIcon) {
      case '☀️':
        return 'images/sunny.jpg';
      case '🌧️':
        return 'images/rain.jpg';
      case '☁️':
        return 'images/cloudy.jpg';
      case '☔️'||'🌧':
        return 'images/heavyrain.jpg';
      default:
        return 'images/clear.jpg';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:AssetImage(getBackgroundImage()),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.4), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    heroTag: "btn1",
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    heroTag: "btn2",
                    onPressed: () async {
                    var typedName = await
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      },
                    ),
                    );

                    if(typedName != null){
                      var weatherData= await weather.getCityWeather(typedName);
                      updateUI(weatherData);
                    }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Container(
      alignment: Alignment(1,1),
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white30),
      ),
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
      children: <Widget>[
       ListTile(
      title:  Text(
        '$temperature° $weatherIcon',
        style: kTempTextStyle,
      ),
      subtitle:  Text(
        "$weatherMessage in $cityName",
        textAlign: TextAlign.right,
        style: kMessageTextStyle,
      ),
    ),
      ]
      ),
    ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(

                      ),
                      Container(

                        alignment: Alignment(1,0),
                        width: MediaQuery.of(context).size.width - 220,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white30),
                        ),
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: ListTile(
                          title:  Text(
                            'Description',
                            style: kMessageTextStyle,
                          ),
                          subtitle: Text(
                            "$description",
                            textAlign: TextAlign.right,
                            style: kMessageTextStyle,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment(1,0),
                        width: MediaQuery.of(context).size.width - 220,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white30),
                        ),
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: ListTile(
                        title:  Text(
                          'Humidity',
                          style: kMessageTextStyle,
                        ),
                        subtitle: Text(
                          "$humidity %",
                          textAlign: TextAlign.right,
                          style: kMessageTextStyle,
                        ),
                      ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment(1, 0),
                        width: MediaQuery.of(context).size.width -220,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: Colors.white30),
                        ),
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        padding: EdgeInsets.all(10),
                        child:  ListTile(
                          title:  Text(
                            'Wind Speed',
                            style: kMessageTextStyle,
                          ),
                          subtitle: Text(
                            "$windSpeed mph",
                            textAlign: TextAlign.right,
                            style: kMessageTextStyle,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment(1,0),
                        width: MediaQuery.of(context).size.width -220,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: Colors.white30),
                        ),
                          margin: EdgeInsets.fromLTRB(5,5,5,0),
                        padding: EdgeInsets.all(10),
                        child:ListTile(
                          title:  Text(
                            'Visibility',
                            style: kMessageTextStyle,
                          ),
                          subtitle: Text(
                            "$visibility",
                            textAlign: TextAlign.right,
                            style: kMessageTextStyle,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                        alignment: Alignment(1,0),
                        width: MediaQuery.of(context).size.width -20,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white30),
                        ),
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child:ListTile(
                          title:  Text(
                            'Pressure',
                            style: kMessageTextStyle,
                          ),
                          subtitle: Text(
                            "$pressure inHigh",
                            textAlign: TextAlign.right,
                            style: kMessageTextStyle,
                          ),
                        ),
                      ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

