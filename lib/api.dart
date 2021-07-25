import 'package:flutter/material.dart';

var hourbuttoncolour = Colors.blueGrey.withOpacity(0.4);
var daybuttoncolour = null;
var cityname= '...';
var country = '...';
int currenttemp = 0;
double currentfeel= 0;
int CurrentFeel= 0;
var clouds;
var mainthing='...';
var desc='...';
var pressure=0;
var humidity=0;
double windspeed=0;
var winddegree=0;
var bg='clear';
var bgcode= 800;
int j=0;
var timezone='...';

var hourcondition= new List(3);
var hourcode=new List(3);
var hourtemp=new List(3);
var hourcloud=new List(3);
var daycondition= new List(3);
var daycode=new List(3);
var daymax=new List(3);
var daymin=new List(3);