import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/cubit/popular_movies_cubit.dart';
import 'package:movie_app/pages/popular_movies_details_page.dart';
import 'package:movie_app/pages/movie_search_page.dart';
import 'package:movie_app/pages/settings.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {

  bool showFab = true;
   ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _loadPopularMovies();
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: showFab ? FloatingActionButton.extended(

        extendedTextStyle: GoogleFonts.poppins(),

          onPressed: (){
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MovieSearchPage()));
          },

          icon: Icon(Icons.search),
          label: Text("BROWSE MOVIES",),
        backgroundColor: Colors.blueGrey.withOpacity(0.6),

      ) : null,
      body: BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          if(state is MoviesLoadingInProgress){
            return Center(child: CircularProgressIndicator(),);
          } else if(state is MoviesLoadingSucceeded){
            var data = state.popularMoviesResults;
            var popularMovies = data.results;
            return NotificationListener<UserScrollNotification>(
              onNotification: (notification){
               setState(() {
                 if(notification.direction == ScrollDirection.forward){
                   showFab = true;
                 } else if(notification.direction == ScrollDirection.reverse){
                   showFab = false;
                 }
               });
                return true;
              },
              child: ListView.builder(
                controller: _scrollController,
                  itemCount: popularMovies.length,
                  itemBuilder: (context, index){

                  return Stack(
                    children: [
                      Positioned(
                        child: Container(
                            width: double.infinity,
                            // color: Colors.black,
                            height: 220,
                            margin: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: "$imageBaseUrl/${popularMovies[index].backdropPath}",
                                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                                fit: BoxFit.fill,
                              ),
                            )
                        ),
                        bottom: 0,
                        right: 0,
                        left: 0,
                        top: 0,
                      ),

                      InkWell(
                        onTap:(){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PopularMoviesDetailsPage(popularMovies: popularMovies[index]))
                          );
                        },

                    child: Container(
                    margin: EdgeInsets.all(16.0),
                    width:  double.infinity,
                    height: 231,

                    decoration: BoxDecoration(
                    gradient: LinearGradient(
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter,
                    colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.white.withOpacity(0.0),
                    ]
                    ),
                    borderRadius: BorderRadius.circular(20)
                    ),
                    ),

                      ),

                      InkWell(
                        onTap:(){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PopularMoviesDetailsPage(popularMovies: popularMovies[index]))
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(19.0),
                          width: double.infinity,
                          height: 210,
                          alignment: Alignment.bottomLeft,
                          // color: Colors.amberAccent,
                          child: Text(popularMovies[index].title,
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),

                          ),
                        ),
                      )
                    ],
                  );
              }),
            );

          }
           return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _loadPopularMovies() {
    BlocProvider.of<MoviesCubit>(context).loadPopularMovies();
  }
}
