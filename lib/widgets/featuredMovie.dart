import 'package:flutter/material.dart';
import 'package:movie_viewer/widgets/textTheme.dart';


class featuredMovie extends StatelessWidget {
  Map movie;
  featuredMovie(this.movie);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0,0,0,0),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(20,5,20,20),
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Image.network(
                  "http://image.tmdb.org/t/p/w500"+movie['poster_path'],
                  fit: BoxFit.fill,
                )
            ),
            textTheme('Featured film of the Week:', 25, Colors.white, ''),
            textTheme(movie['name']!=null? movie['name'] : (movie['original_title']!=null? movie['original_title']: "Title unavailable") , 25, Colors.white, '')
          ],
        ),
    );
  }
}
