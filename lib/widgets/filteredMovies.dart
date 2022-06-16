import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_viewer/widgets/movieGenreInfo.dart';


class filteredMovies extends StatelessWidget {
  List movies;
  filteredMovies(this.movies);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: movies.map<Widget>((item) => movieGenreInfo(
            item
        )).toList(),
      );
  }
}
