import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  cursorColor: Colors.black,
                  style:GoogleFonts.ptSans(
                    fontSize: 20,
                    color:Colors.black,
                  ),
                  decoration: InputDecoration(
                    icon :Icon(
                      Icons.location_city,
                      color:Colors.grey,
                    ),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    hintText : 'Enter City Name',
                    hintStyle: GoogleFonts.ptSans(
                      color:Colors.grey,
                    ),
                    disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  ),
                  onChanged: (value){
                    cityName = value;
                  },
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context,cityName);
                },
                child: Text(
                  'Check Weather',
                  style: GoogleFonts.ptSans(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
