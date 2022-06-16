import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_viewer/widgets/textTheme.dart';


class genre extends StatelessWidget {
  List movieGenres;
  genre(this.movieGenres);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.fromLTRB(5,0,5,5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: movieGenres.map<Widget>((item) => Container(
            height: MediaQuery.of(context).size.height* .06,
            width: MediaQuery.of(context).size.width* .3,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.red,
              child: Center(child: textTheme(item['name'], 20, Colors.white, 'ZingRust')),
            ),
        )).toList(),
      ),
    );
  }
}
