import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_viewer/widgets/moviePoster.dart';
import 'package:movie_viewer/widgets/textTheme.dart';

class movieList extends StatelessWidget {
  List movies;
  String title;
  movieList(this.movies, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textTheme(title, 25, Colors.white, ''),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.fromLTRB(5,0,5,5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: movies.map((item) => moviePoster(
                  item
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

