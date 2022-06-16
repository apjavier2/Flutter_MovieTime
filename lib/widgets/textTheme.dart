import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class textTheme extends StatelessWidget {
  String string;
  double size;
  Color color;
  String font;

  textTheme(this.string, this.size, this.color, this.font);

  double convertSize(double s){
    String newSize = "0.0"+(s.toInt()+17).toString();
    return double.parse(newSize);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      style: TextStyle(
          fontSize: MediaQuery.of(context).size.width* convertSize(size),
          fontFamily: font,
          color: color
      ),
    );
  }
}
