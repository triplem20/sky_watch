import 'package:flutter/material.dart';
import 'package:sky_watch/services/weather.dart';
import 'package:sky_watch/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  final TextEditingController _cityNameController = TextEditingController();
  final WeatherModel weatherModel = WeatherModel();


  late int temperature;
  String? weatherIcon;
  late String weatherMessage;
  String? cityName;
  Map<String, dynamic>? weatherData;

  Future<void> _fetchWeatherData() async {
    cityName = _cityNameController.text;
    if (cityName != null && cityName!.isNotEmpty) {
      var data = await weatherModel.getCityWeather(cityName!);
      setState(() {
        weatherData = data;
      });
    }
    var condition = weatherData!['weather'][0]['id'];
    weatherIcon = weatherModel.getWeatherIcon(condition);
    weatherMessage = weatherModel!.getMessage(weatherIcon!);
    num temp = weatherData!['main']['temp'];
    temperature = temp.toInt();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/cityscreen2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FloatingActionButton(
                  heroTag: 'btn3',
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: 250,
                      child: TextFormField(
                        controller: _cityNameController,
                        style: TextStyle(color: Colors.black),
                        decoration: KtextFieldInputDecoration,
                        onChanged: (value) {
                          cityName = value;
                        },
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    heroTag: 'btn4',
                    backgroundColor: Colors.teal,
                    onPressed: () {
                      Navigator.pop(context,cityName);
                    },
                    child: Icon(Icons.search),
                  ),
                ],
              ),
              FloatingActionButton(
                heroTag: 'btn5',
                backgroundColor: Colors.teal,
                onPressed: () {
                  _fetchWeatherData();
                },
                child: Icon(Icons.add),
              ),

              SizedBox(height: 10),
              weatherData == null
                  ? Text('Enter a city name to get weather data')
                  : Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white30),
                ),
                margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                child:
                       ListTile(title:
                            Text('${weatherData!['name']}' '  $temperature°' '$weatherIcon'),
                         subtitle: Text('$weatherMessage'),
                         trailing: SizedBox(
                           width: 90,
                           height: 40,
                           child: FloatingActionButton(
                             backgroundColor: Colors.teal,
                               onPressed: (){Navigator.pop(context,cityName);}, child: Text('View Details')),
                         ),

                       ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
