import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Services.dart';
import 'location_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  WeatherModel weatherModel = WeatherModel();

  @override
  void initState(){
    super.initState();
    getLocationData();

  }

  void getLocationData() async{

    var weatherData = await weatherModel.getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder:(context)
    {
      return LocationScreen(weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Weather App', style: GoogleFonts.ptSans(fontWeight: FontWeight.w700, fontSize: 22, color: Colors.white),),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white.withOpacity(0.7),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator()
            ],),
        ),
      ),
    );
  }
}
