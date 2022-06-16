import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_viewer/widgets/genre.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../widgets/textTheme.dart';


class movieInfo extends StatefulWidget {
  int movieId;
  movieInfo(this.movieId);
  @override
  State<movieInfo> createState() => _movieInfoState();
}

class _movieInfoState extends State<movieInfo> {
  Map movie = {};


  Future<bool> loadData() async{
    //load more information about the movie
    Response movie_response = await get(Uri.parse('${dotenv.env['base_url']}movie/${widget.movieId}?api_key=${dotenv.env['api_key']}&language=en-US'));
    if(movie_response.body.isNotEmpty){
      Map featured_data = jsonDecode(movie_response.body);
      if(featured_data['success'] == false){
        return false;
      }
      movie = featured_data;
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: FutureBuilder(
                future: loadData(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return(
                        Center(
                          child: SizedBox(
                            child: CircularProgressIndicator(color: Colors.white),
                            height: 50.0,
                            width: 50.0,
                        )
                    ));
                  }
                  if(snapshot.hasData && snapshot.data == false){
                    return(
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0,50,0,0),
                          child: textTheme('Unable to load movie! Try Again.', 15, Colors.white, 'PoppinsRegular')
                        ),
                      )
                    );
                  }
                  return(
                      Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin:  EdgeInsets.fromLTRB(5,40,5,10),
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  height: MediaQuery.of(context).size.height * 0.55,
                                  child: Image.network(
                                    "http://image.tmdb.org/t/p/w500"+movie['poster_path'],
                                    fit: BoxFit.fill,
                                  )
                              ),
                              textTheme(movie['name']!=null? movie['name'] : (movie['original_title']!=null? movie['original_title']: "Title unavailable"), 25, Colors.red, ''),
                              Container(
                                  margin: EdgeInsets.all(20) ,
                                  width: MediaQuery.of(context).size.width * 0.95,
                                  // height: MediaQuery.of(context).size.height * 0.55,
                                  child: textTheme(movie['overview'], 20, Colors.white, ''),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(20, 0,0,10),
                                  child: textTheme('Released Date: ${movie['release_date']}', 20, Colors.white, "")
                                )
                              ),
                              genre(movie['genres'])
    

                            ],
                          )
                      )
                  );
                }
            ),
          ),
        )
    );
  }
}
