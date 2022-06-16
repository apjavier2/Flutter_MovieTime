import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_viewer/widgets/textTheme.dart';



class moviePoster extends StatelessWidget {
  Map movie;
  moviePoster(this.movie);

  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, '/movieInfo', arguments: [movie['id']]);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(0,5,0,15),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(5,0,5,10) ,
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.network(
                  "http://image.tmdb.org/t/p/w500"+movie['poster_path'],
                  fit: BoxFit.fill,
                )
            ),
            textTheme(movie['original_title']!=null? (movie['original_title'].length > 15? movie['original_title'].substring(0,15)+"...": movie['original_title']): "No Title", 20, Colors.white, '')
          ],
        ),
      ),
    );
  }
}
