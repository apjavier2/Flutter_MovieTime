import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/movieInfo.dart';


Route<dynamic> generateRoute(RouteSettings settings){
  switch (settings.name){
    case '/home':
      return MaterialPageRoute(builder: (context) => home());
    case '/movieInfo':
      var data = settings.arguments as List;
      return MaterialPageRoute(builder: (context) => movieInfo(data[0]));
    default:
      return MaterialPageRoute(builder: (context) => home());
  }
}