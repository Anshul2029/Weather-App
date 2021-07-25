import 'package:flutter/material.dart';

class nextdays extends StatelessWidget {
  nextdays({this.max, this.min,this.code,this.condition});
  var max;
  var min;
  var code;
  var condition;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: <Widget>[
            SizedBox(height: 1.5,),
            Image(image: AssetImage('images/'+code.toString()+'.png'),
              height: 50,
              width: 50,
            ),
            Text(condition.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),),
            SizedBox(height: 3,),
            gettext('Max: '+max.toString()+'°C',14),
            SizedBox(height: 2,),
            gettext('Min: '+min.toString()+'°C', 14),
          ],
        ),
      ),
    );
  }
}

class nexthours extends StatelessWidget {
  nexthours({this.temp,this.code,this.condition,this.cloud});
  var temp;
  var code;
  var condition;
  var cloud;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: <Widget>[
            SizedBox(height: 1.5,),
            Image(image: AssetImage('images/'+code.toString()+'.png'),
              height: 50,
              width: 50,
            ),
            Text(condition.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),),
            SizedBox(height: 3,),
            gettext('Temp : '+temp.toString()+'°C', 14),
            SizedBox(height: 2,),
            gettext('Cloud : '+cloud.toString()+'%', 14),
          ],
        ),
      ),
    );
  }
}

Text gettext(String s, double font)
{
  return Text(s,
    style: TextStyle(
      fontSize: font,
      color: Colors.white,
    ),
  );
}

String getbg(int bgcode){
  if(bgcode>801)
    {return 'overcast';}
  else if(bgcode==801)
  {return 'fewclouds';}
  else if(bgcode==800)
  {return 'clear';}
  else if(bgcode==721)
  {return 'haze';}
  else if(bgcode>599)
  {return 'snow';}
  else if(bgcode>499)
  {return 'rain';}
  else if(bgcode>299)
  {return 'drizzle';}
  else{
    return 'thunderstorm';
  }
}