import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location; //location name for that ui
  late String time; //the time in that location
  String flag; //url to an asset flag icon
  String url;  //location url for api endpoint
  late bool isDayTime; //true of false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try{
      Response response= await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data= jsonDecode(response.body);
      // print(data);

      // get properties from data
      String datetime= data['datetime'];
      String offset= data['utc_offset'].substring(1,3);
      // print(datetime);
      // print(offset);

      //create DateTime object
      DateTime now= DateTime.parse(datetime);
      // print(now);
      now= now.add(Duration(hours: int.parse(offset)));

      isDayTime= now.hour> 6 || now.hour< 20? true: false;

      //set time property
      time = DateFormat.jm().format(now);

      // print(now);
    }
    catch(e)
    {
      print('Caught exception : $e');
      time= 'Could not get time data -_-';
    }
  }


}