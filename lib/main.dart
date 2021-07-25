import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'api.dart';
import 'functions.dart';

void main() {
  runApp(firstscreen());
}

class firstscreen extends StatefulWidget {
  @override
  _firstscreenState createState() => _firstscreenState();
}

class _firstscreenState extends State<firstscreen> {
  @override
  void initState() {
    super.initState();
    getlocation();
  }

  void getweather(double lat, double lon) async {
    var weatherurl =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=5eabdac929bc4e10787cc5b6481b1356';
    var response;
    response = await http.get(weatherurl);
    if (response.statusCode == 200) {
      var currentResponse = convert.jsonDecode(response.body);
      print(currentResponse);
      setState(() {
        cityname = currentResponse['name'];
        country = currentResponse['sys']['country'];
        currenttemp = currentResponse['main']['temp'];
        currentfeel = currentResponse['main']['feels_like'];
        CurrentFeel = currentfeel.round();
        clouds = currentResponse['clouds']['all'];
        mainthing = currentResponse['weather'][0]['main'];
        desc = currentResponse['weather'][0]['description'];
        pressure = currentResponse['main']['pressure'];
        humidity = currentResponse['main']['humidity'];
        windspeed = (currentResponse['wind']['speed']) * 3.6;
        winddegree = currentResponse['wind']['deg'];
        bgcode = currentResponse['weather'][0]['id'];
        bg = getbg(bgcode);
      });
      var hourlyurl =
          'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&exclude=current,minutely&appid=5eabdac929bc4e10787cc5b6481b1356';
      var hourresponse = await http.get(hourlyurl);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(hourresponse.body);
        setState(() {
          for (var i = 0; i < 3; i++) {
            hourtemp[i] =  jsonResponse['hourly'][i]['temp'];
            hourcloud[i]=  jsonResponse['hourly'][i]['clouds'];
            hourcondition[i]=  jsonResponse['hourly'][i]['weather'][0]['main'];
            hourcode[i]= jsonResponse['hourly'][i]['weather'][0]['icon'];
            daycondition[i]= jsonResponse['daily'][i]['weather'][0]['main'];
            daycode[i]= jsonResponse['daily'][i]['weather'][0]['icon'];
            daymax[i]= jsonResponse['daily'][i]['temp']['max'];
            daymin[i]= jsonResponse['daily'][i]['temp']['min'];
          };
          timezone= jsonResponse['timezone'];
        });
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void getlocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print(position);
    getweather(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(0, 0, 0, 0.85),
            bottomOpacity: 0.1,
            centerTitle: true,
            title: Text('Weather',
            style: TextStyle(
              fontFamily: 'Kalam',
              fontSize: 30,
              color: Colors.white,
            ),),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/$bg.jpg'),
              fit: BoxFit.fill,
            )),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: Text(
                    '$cityname, $country',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 38,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  child: Text(
                    'Timezone : '+timezone.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black38.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10)),
                      width: double.infinity,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          gettext(currenttemp.toString() + '°C', 70),
                          SizedBox(width: 20),
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 19,
                              ),
                              gettext('Feels-like : $CurrentFeel°C', 20),
                              SizedBox(
                                height: 5,
                              ),
                              gettext(
                                  ('Clouds : ' + clouds.toString() + '%'), 20),
                            ],
                          )
                        ],
                      )),
                ),
                SizedBox(
                  height: 35,
                ),
                Container(
                  width: 360,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Column(
                      children: <Widget>[
                        gettext(mainthing, 48),
                        SizedBox( height: 2, ),
                        gettext(desc, 18),
                        SizedBox( height: 40, ),
                        gettext('Pressure : ' + pressure.toString(), 20),
                        SizedBox( height: 4, ),
                        gettext('Humidity : ' + humidity.toString() + '%', 20),
                        SizedBox( height: 4, ),
                        gettext( 'Windspeed : ' + windspeed.toStringAsFixed(2) + 'km/h  ' + winddegree.toString() + '°N', 20),
                      ],
                    ),
                  ),
                ),
                SizedBox( height: 25, ),
                Container(
                  height: 173,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                color: hourbuttoncolour,
                                child: Text(
                                  'Next 3 hours',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    hourbuttoncolour =
                                        Colors.blueGrey.withOpacity(0.4);
                                    daybuttoncolour = null;
                                    j=0;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: FlatButton(
                                color: daybuttoncolour,
                                child: Text(
                                  'Next 3 days',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    daybuttoncolour =
                                        Colors.blueGrey.withOpacity(0.4);
                                    hourbuttoncolour = null;
                                    j=1;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Container(
                          color: Colors.blueGrey.withOpacity(0.35),
                          child: Row(
                            children: <Widget>[
                              j==0 ? nexthours(temp: hourtemp[0],code: hourcode[0],condition: hourcondition[0],cloud: hourcloud[0],) : nextdays(max: daymax[0],min: daymin[0],code: daycode[0],condition: daycondition[0],),
                              j==0 ? nexthours(temp: hourtemp[1],code: hourcode[1],condition: hourcondition[1],cloud: hourcloud[1],) : nextdays(max: daymax[1],min: daymin[1],code: daycode[1],condition: daycondition[1],),
                              j==0 ? nexthours(temp: hourtemp[2],code: hourcode[2],condition: hourcondition[2],cloud: hourcloud[2],) : nextdays(max: daymax[2],min: daymin[2],code: daycode[2],condition: daycondition[2],),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
