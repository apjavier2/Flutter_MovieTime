import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_viewer/widgets/filteredMovies.dart';
import 'package:movie_viewer/widgets/moviesList.dart';
import '../widgets/featuredMovie.dart';
import '../widgets/textTheme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  //Data holders:
  Map featured = {};
  List trending = [];
  List popular = [];
  List genres = [];
  List np = [];

  //Flags:
  bool isGenre = false;

  //Genre selected
  late int genreID;
  List genreMovies = [];
  int page = 1;


  //TO DO: Use.env for api key
  Future<bool> loadData() async{
    int loadedCount = 0;
    //load featured/trending movie and get the first one on the list
    Response featured_response = await get(Uri.parse('${dotenv.env['base_url']}trending/all/day?api_key=${dotenv.env['api_key']}&language=en-US'));
    if(featured_response.body.isNotEmpty){
      Map featured_data = jsonDecode(featured_response.body);
      featured = featured_data['results'][0];
      trending = featured_data['results'];
      loadedCount++;
    }

    //load popular movies:
    Response popular_response = await get(Uri.parse('${dotenv.env['base_url']}movie/popular?api_key=${dotenv.env['api_key']}&language=en-US&page=1'));
    if(popular_response.body.isNotEmpty){
      Map popular_data = jsonDecode(popular_response.body);
      popular = popular_data['results'];
      loadedCount++;
    }

    // //load now playing movies:
    Response np_response = await get(Uri.parse('${dotenv.env['base_url']}movie/now_playing?api_key=${dotenv.env['api_key']}&language=en-US&page=1'));
    if(np_response.body.isNotEmpty){
      Map np_data = jsonDecode(np_response.body);
      np = np_data['results'];
      print(np);
      loadedCount++;
    }

    //load the genres:
    Response genre_response = await get(Uri.parse('${dotenv.env['base_url']}genre/movie/list?api_key=${dotenv.env['api_key']}&language=en-US'));
    if(genre_response.body.isNotEmpty){
      Map genre_data = jsonDecode(genre_response.body);
      genres = genre_data['genres'];
      loadedCount++;
    }

    //This is to check if all the api calls were successful
    if(loadedCount > 1){
      return true;
    }
    return false;
  }

  Future<bool> loadGenreData() async{
    //load filtered by genre movies:
    Response genre_response = await get(Uri.parse('${dotenv.env['base_url']}discover/movie?with_genres=${genreID}&api_key=${dotenv.env['api_key']}&page=${page}'));
    if(genre_response.body.isNotEmpty){
      Map genre_data = jsonDecode(genre_response.body);
      genreMovies = genre_data['results'];
      featured = genreMovies[0];
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: FractionalOffset.centerLeft,
              child: InkWell(
                onTap: (){
                  setState(() {
                    isGenre = false;
                  });
                },
                child: Container(
                    padding: EdgeInsets.fromLTRB(20,40,0,5),
                    child: textTheme('Movie Time', 50, Colors.red, 'PoppinsRegular')                              //A logo can be addded here
                ),
              ),
            ),
            FutureBuilder(
                future: isGenre? loadGenreData() : loadData(),
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
                    return (textTheme('Error Occurred, try again!', 15, Colors.white, 'PoppinsRegular'));
                  }
                  return(
                      Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.fromLTRB(5,0,5,5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: genres.map<Widget>((item) => InkWell(
                                    onTap: (){
                                      setState(() {
                                        isGenre = true;
                                        genreID = item['id'];
                                      });
                                    },
                                    child: Container(
                                      height: MediaQuery.of(context).size.height* .06,
                                      width: MediaQuery.of(context).size.width* .3,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        color: Colors.red,
                                        child: Center(child: textTheme(item['name'], 20, Colors.white, 'ZingRust')),
                                      ),
                                    ),
                                  )).toList(),
                                ),
                              ),
                              featuredMovie(featured),
                              !isGenre? movieList(popular, "Popular") : SizedBox(height: 0),
                              !isGenre? movieList(trending, "Trending"): SizedBox(height: 0),
                              !isGenre? movieList(np, "Now Playing"): SizedBox(height: 0),
                              isGenre? filteredMovies(genreMovies): SizedBox(height: 0)
                            ],
                          )
                      )
                  );
                }
            ),
          ],
        )
      )
    );
  }
}
