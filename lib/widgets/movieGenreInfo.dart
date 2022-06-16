import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_viewer/widgets/textTheme.dart';



class movieGenreInfo extends StatelessWidget {
  Map movie;
  movieGenreInfo(this.movie);

  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, '/movieInfo', arguments: [movie['id']]);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(0,10,0,15),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.grey[900],
          child: Row(
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(5,10,5,10) ,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.network(
                    "http://image.tmdb.org/t/p/w500"+movie['poster_path'],
                    fit: BoxFit.fill,
                  )
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textTheme(movie['original_title']!=null? (movie['original_title'].length > 15? movie['original_title'].substring(0,15)+"...": movie['original_title']): "No Title", 20, Colors.red, ''),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: textTheme(movie['overview'].length > 250? movie['overview'].substring(0,250)+"..." : movie['overview'], 15, Colors.white, '')
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
