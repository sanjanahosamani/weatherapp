import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Services.dart';
import 'cityscreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LocationScreen extends StatefulWidget {
  @override
  LocationScreen(this.locationWeather);

  final locationWeather;
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  String city;
  int temperature;
  String conditionIcon;
  String conditionMsg;
  String description;
  int humidity;
  int wind;
  WeatherModel weather = WeatherModel();
  @override
  void initState(){
    super.initState();
    updateUI(widget.locationWeather);
  }


  void updateUI(dynamic weatherData)
  {
    setState(() {
      if(weatherData == null){
        temperature = 0;
        conditionIcon ='Error';
        conditionMsg = 'Unable to Fetch location';
        city = '';
        return;
      }

      city = weatherData ['name'];
      temperature =  weatherData ['main']['temp'].toInt();
      print(temperature);
      int condition = weatherData ['weather'][0]['id'];
      conditionIcon = weather.getWeatherIcon(condition);
      description = weatherData['weather'][0]['description'];
      humidity = weatherData['main']['humidity'].toInt();
      wind = weatherData['wind']['speed'].toInt();
      print(wind);
      print(humidity);
      print(description);
    });

  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.location_searching),
          onPressed: () async {
            var weatherData = await weather.getLocationWeather();
            print('$weatherData');
            updateUI(weatherData);
          },),
        centerTitle: true,
        title: Text('Weather App', style: GoogleFonts.ptSans(fontWeight: FontWeight.w700, fontSize: 22, color: Colors.white),),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () async {
            var  typedName = await  Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CityScreen()
              ),
            );
            print(typedName);
            if(typedName != null)
            {
              var weatherData = await weather.getCityWeather(typedName);
              print(weatherData);
              updateUI(weatherData);
            }
          })
        ],
      ),


      body: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height/3,
                width: MediaQuery.of(context).size.width,
                    color: Color(0xFF251286),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text('Currently in $city', style: GoogleFonts.ptSans(fontWeight: FontWeight.bold, fontSize: 25,color: Colors.white),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('$temperature°C', style: GoogleFonts.ptSans(fontWeight: FontWeight.w700, fontSize: 40, color: Colors.white),),
                            SizedBox(width: 10,),
                            Text('$conditionIcon', style: TextStyle(fontSize: 30),),
                          ],
                        ),
                        Text('$description',style: GoogleFonts.ptSans(fontWeight: FontWeight.w500, fontSize: 20,color: Colors.white),),


                      ],
                    ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(MdiIcons.thermometer),
                        title: Text('Temperature', style: GoogleFonts.ptSans(fontSize: 22)),
                        trailing: Text('$temperature°C', style: GoogleFonts.ptSans(fontWeight: FontWeight.w700, fontSize: 22),),
                      ),
                      ListTile(
                        leading: Icon(Icons.cloud),
                        title: Text('Weather', style: GoogleFonts.ptSans(fontSize: 22)),
                        trailing: Text('$description', style: GoogleFonts.ptSans(fontWeight: FontWeight.w700, fontSize: 20),),
                      ),
                      ListTile(
                        leading: Icon(Icons.wb_sunny),
                        title: Text('Humidity', style: GoogleFonts.ptSans(fontSize: 22)),
                        trailing: Text('$humidity', style: GoogleFonts.ptSans(fontWeight: FontWeight.w700, fontSize: 22),),
                      ),
                      ListTile(
                        leading: Icon(MdiIcons.weatherWindy),
                        title: Text('Wind', style: GoogleFonts.ptSans(fontSize: 22)),
                        trailing: Text('$wind', style: GoogleFonts.ptSans(fontWeight: FontWeight.w700, fontSize: 22),),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),

    );
  }
}