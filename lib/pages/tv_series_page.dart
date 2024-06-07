import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/cubit/airing_today_tv_series_cubit.dart';
import 'package:movie_app/cubit/popular_tv_series_cubit.dart';
import 'package:movie_app/cubit/top_rated_tv_series_cubit.dart';
import 'package:movie_app/cubit/tv_series_genres_cubit.dart';
import 'package:movie_app/data/popular_tv_series.dart';
import 'package:movie_app/pages/settings.dart';
import 'package:movie_app/pages/tv_series_details_page.dart';
import 'package:movie_app/pages/tv_series_search_page.dart';

class TvSeriesPage extends StatefulWidget {
  const TvSeriesPage({Key? key}) : super(key: key);

  @override
  _TvSeriesPageState createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage> {
  bool showFab = true;
  ScrollController _scrollController = ScrollController();
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _loadPopularTvSeries();
    _loadTopRatedTvSeries();
    _loadAiringTodayTvSeries();
    _loadTvSeriesGenres();
  }
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton:showFab ? FloatingActionButton.extended(

          extendedTextStyle: GoogleFonts.poppins(),

          onPressed: (){
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TvSeriesSearchPage()));
          },
          icon: Icon(Icons.search),
          label: Text("BROWSE TV SERIES",),
          backgroundColor: Colors.blueGrey.withOpacity(0.6),

        ) : null,
      body: NotificationListener<UserScrollNotification>(
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
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //popular tv series
              BlocBuilder<PopularTvSeriesCubit, PopularTvSeriesState>(
                builder: (context, state){
                  if(state is PopularTvSeriesLoadingSucceeded){
                    var popularTvSeriesList = state.popularTvSeriesResults.results;
                    return SizedBox(
                      height: 250,

                      child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 10,
                          ),

                          //carousel
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: CarouselSlider.builder(
                                itemCount: popularTvSeriesList.length,
                                itemBuilder: (context, index, realIndex){
                                  var popularTvSeries =  popularTvSeriesList[index];
                                 if(popularTvSeries.backdropPath != null){
                                   return Stack(
                                     children: [
                                       //backdrop image
                                       SizedBox(
                                         height: 350,
                                         width: 350,
                                         child: ClipRRect(
                                           child: CachedNetworkImage(
                                             imageUrl: "$imageBaseUrl/${popularTvSeries.backdropPath}",
                                             placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                             errorWidget: (context, url, error) => Icon(Icons.error),
                                             fit: BoxFit.fill,
                                           ),
                                           borderRadius: BorderRadius.circular(20),
                                         ),
                                       ),

                                       //shade
                                       InkWell(
                                         child: Container(
                                           // margin: EdgeInsets.all(8.0),
                                           width:  double.infinity,
                                           height: 350,

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
                                         onTap:(){
                                           Navigator.push(
                                               context,
                                               MaterialPageRoute(builder: (context) => TvSeriesDetailsPage(popularTvSeries: popularTvSeries,))
                                           );
                                         },
                                       ),

                                       //title
                                       Container(
                                         margin: EdgeInsets.all(14.0),
                                         width: double.infinity,
                                         height: 210,
                                         alignment: Alignment.bottomLeft,
                                         // color: Colors.amberAccent,
                                         child: Text(popularTvSeries.name,
                                           style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),

                                         ),
                                       )

                                     ],
                                   );

                                 }else


                                   return Stack(
                                     children: [
                                       //backdrop image
                                       SizedBox(
                                         height: 350,
                                         width: 350,
                                         child: ClipRRect(
                                           child: CachedNetworkImage(
                                             imageUrl: "$imageBaseUrl/${popularTvSeries.posterPath}",
                                             placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                             errorWidget: (context, url, error) => Icon(Icons.error),
                                             fit: BoxFit.fill,
                                           ),
                                           borderRadius: BorderRadius.circular(10),
                                         ),
                                       ),

                                       //shade
                                       Container(
                                         // margin: EdgeInsets.all(8.0),
                                         width:  double.infinity,
                                         height: 350,

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

                                       //title
                                       Container(
                                         margin: EdgeInsets.all(14.0),
                                         width: double.infinity,
                                         height: 210,
                                         alignment: Alignment.bottomLeft,
                                         // color: Colors.amberAccent,
                                         child: Text(popularTvSeries.name,
                                           style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),

                                         ),
                                       )

                                     ],
                                   );
                                },
                                options: CarouselOptions(
                                  enableInfiniteScroll: true,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 3),
                                  autoPlayAnimationDuration: Duration(microseconds: 1000),
                                  pauseAutoPlayOnTouch: true,
                                  viewportFraction: 0.8,
                                  enlargeCenterPage: true,
                                )
                            ),
                          ),
                      ]
                    )
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                  },
              ),

              // BlocBuilder<TvSeriesGenresCubit, TvSeriesGenresState>(
              //
              //     builder: (context, state){
              //       if(state is TvSeriesGenresLoadingSucceeded){
              //         var genreList = state.tvSeriesGenresResults.genres;
              //
              //         return SingleChildScrollView(
              //           scrollDirection: Axis.horizontal,
              //           child: Row(
              //
              //             children: genreList.map((e) => Padding(
              //               padding: const EdgeInsets.all(4.0),
              //               child: ActionChip(
              //                 label: Text(e.name),
              //                  onPressed: (){
              //
              //                  },
              //                 labelStyle: GoogleFonts.poppins(color: Colors.white),
              //                 backgroundColor: Colors.black54,
              //
              //               ),
              //             )).toList()
              //           ),
              //         );
              //
              //
              //       } else if(state is TvSeriesGenresLoadingFailed){
              //         return Center(child: Text(state.Message.toString()));
              //       }
              //       return Center(child: CircularProgressIndicator());
              //     }
              //
              //     ),



              //Top rated header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Top Rated", style: GoogleFonts.poppins(color:Colors.black.withOpacity(0.9), fontWeight: FontWeight.bold, fontSize: 18 ),),
              ),

              Divider(
                height: 0,
                endIndent: 330,
                indent: 20,
                thickness: 4,
                color: Colors.black,
              ),

              SizedBox(
                height: 17,
              ),


              //top rated tv series
              BlocBuilder<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
                  builder: (context, state){
                    if(state is TopRatedTvSeriesLoadingSucceeded){
                      var topRatedTvSeriesList = state.topRatedTvSeriesResults.results;
                      return SizedBox(
                        height: 300,

                        child: GridView.builder(
                            itemCount: topRatedTvSeriesList.length,
                            scrollDirection: Axis.horizontal,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisExtent: 250,
                                mainAxisSpacing: 16

                            ), itemBuilder: (context, index){
                                var topRatedTvSeries = topRatedTvSeriesList[index];
                                var tvSeries = topRatedTvSeriesList.map((e) => PopularTvSeries(backdropPath: e.backdropPath, firstAirDate: e.firstAirDate, genreIds: e.genreIds, id: e.id, name: e.name, originCountry: e.originCountry, originalLanguage: e.originalLanguage, originalName: e.originalName, overview: e.overview, popularity: e.popularity, posterPath: e.posterPath, voteAverage: e.voteAverage, voteCount: e.voteCount)).toList();
                              if(topRatedTvSeries.backdropPath != null){
                                return Container(
                                  // height: 200,
                                  // width: 200,
                                  decoration: BoxDecoration(
                                    // color: Colors.blue
                                  ),
                                  child: Stack(
                                    children: [

                                      //top rated tv series backdrop image
                                      Positioned(
                                        child: ClipRRect(
                                          child: CachedNetworkImage(
                                            imageUrl: "$imageBaseUrl/${topRatedTvSeries.backdropPath}",
                                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        top: 0,
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                      ),

                                      //shade
                                      InkWell(
                                        child: Container(
                                          // margin: EdgeInsets.all(8.0),
                                          width:  double.infinity,
                                          height: 300,

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
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => TvSeriesDetailsPage(popularTvSeries: tvSeries[index]))
                                          );
                                        },
                                      ),


                                      //top rated series title

                                      Container(
                                        margin: EdgeInsets.all(14.0),
                                        width: double.infinity,
                                        // height: 60,
                                        alignment: Alignment.bottomLeft,
                                        // color: Colors.amberAccent,
                                        child: Column(
                                          children: [
                                            Text(topRatedTvSeries.name,
                                              style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),

                                            ),
                                            //stars
                                            Row(
                                              children: [
                                                Icon(Icons.star,color: Colors.yellow,),
                                                Icon(Icons.star,color: Colors.yellow,),
                                                Icon(Icons.star,color: Colors.yellow,),
                                                Icon(Icons.star,color: Colors.yellow,),
                                                Icon(Icons.star,color: Colors.yellow,),

                                                //rating
                                                Text(topRatedTvSeries.voteAverage.toString(),
                                                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),

                                                ),

                                              ],
                                            )
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        ),
                                      )

                                    ],
                                  ),
                                );
                              }


                              else{

                                return Container(
                                  // height: 200,
                                  // width: 200,
                                  decoration: BoxDecoration(
                                    // color: Colors.blue
                                  ),
                                  child: Stack(
                                    children: [

                                      //top rated tv series backdrop image
                                      Positioned(
                                        child: ClipRRect(
                                          child: CachedNetworkImage(
                                            imageUrl: "$imageBaseUrl/${topRatedTvSeries.posterPath}",
                                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        top: 0,
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                      ),

                                      //shade
                                      InkWell(

                                        child: Container(
                                          // margin: EdgeInsets.all(8.0),
                                          width:  double.infinity,
                                          height: 300,

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
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => TvSeriesDetailsPage(popularTvSeries: tvSeries[index]))
                                          );
                                        },
                                      ),


                                      //top rated series title

                                      Container(
                                        margin: EdgeInsets.all(14.0),
                                        width: double.infinity,
                                        // height: 60,
                                        alignment: Alignment.bottomLeft,
                                        // color: Colors.amberAccent,
                                        child:
                                          Column(
                                          children: [
                                            Text(topRatedTvSeries.name,
                                              style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),

                                            ),
                                            //stars
                                            Row(
                                              children: [
                                                Icon(Icons.star,color: Colors.yellow,),
                                                Icon(Icons.star,color: Colors.yellow,),
                                                Icon(Icons.star,color: Colors.yellow,),
                                                Icon(Icons.star,color: Colors.yellow,),
                                                Icon(Icons.star,color: Colors.yellow,),

                                                //rating
                                                Text(topRatedTvSeries.voteAverage.toString(),
                                                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),

                                                ),

                                              ],
                                            )
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        ),
                                      )

                                    ],
                                  ),
                                );
                              }
                        }),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  }),

              SizedBox(
                height: 16,
              ),

              //Airing today text
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Airing Today", style: GoogleFonts.poppins(color:Colors.black.withOpacity(0.9), fontWeight: FontWeight.bold, fontSize: 18 ),),
              ),

              Divider(
                height: 0,
                endIndent: 330,
                indent: 20,
                thickness: 4,
                color: Colors.black,
              ),

              SizedBox(
                height: 17,
              ),

              BlocBuilder<AiringTodayTvSeriesCubit, AiringTodayTvSeriesState>(
                builder: (context, state) {
                  if(state is AiringTodayTvSeriesLoadingSucceeded){
                    var data = state.airingTodayTvSeriesResults;
                    var airingTodayMovies = data.results;
                    var tvSeries = airingTodayMovies.map((e) => PopularTvSeries(backdropPath: e.backdropPath, firstAirDate: e.firstAirDate, genreIds: e.genreIds, id: e.id, name: e.name, originCountry: e.originCountry, originalLanguage: e.originalLanguage, originalName: e.originalName, overview: e.overview, popularity: e.popularity, posterPath: e.posterPath, voteAverage: e.voteAverage, voteCount: e.voteCount)).toList();

                    return ListView.builder(
                      // scrollDirection: Axis.vertical,
                        padding: EdgeInsets.all(8),
                        shrinkWrap: true,
                        itemCount: airingTodayMovies.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){

                          if(airingTodayMovies[index].backdropPath != null){

                            return Stack(
                              children: [
                                Positioned(
                                  child: Container(
                                      width: double.infinity,
                                      // color: Colors.black,
                                      height: 220,
                                      margin: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: CachedNetworkImage(
                                          imageUrl: "$imageBaseUrl/${airingTodayMovies[index].backdropPath}",
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
                                  child: Container(
                                    margin: EdgeInsets.all(8.0),
                                    width:  double.infinity,
                                    height: 221,

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
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => TvSeriesDetailsPage(popularTvSeries: tvSeries[index]))
                                    );
                                  },
                                ),

                                Container(
                                  margin: EdgeInsets.all(14.0),
                                  width: double.infinity,
                                  height: 210,
                                  alignment: Alignment.bottomLeft,
                                  // color: Colors.amberAccent,
                                  child: Text(airingTodayMovies[index].name,
                                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),

                                  ),
                                )
                              ],
                            );
                          } else{
                            return Stack(
                              children: [
                                Positioned(
                                  child: Container(
                                      width: double.infinity,
                                      // color: Colors.black,
                                      height: 220,
                                      margin: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: CachedNetworkImage(
                                          imageUrl: "$imageBaseUrl/${airingTodayMovies[index].posterPath}",
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

                                Container(
                                  margin: EdgeInsets.all(8.0),
                                  width:  double.infinity,
                                  height: 220,

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

                                Container(
                                  margin: EdgeInsets.all(14.0),
                                  width: double.infinity,
                                  height: 210,
                                  alignment: Alignment.bottomLeft,
                                  // color: Colors.amberAccent,
                                  child: Text(airingTodayMovies[index].name,
                                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),

                                  ),
                                )
                              ],
                            );
                          }

                        });

                  }else if(state is AiringTodayTvSeriesLoadingFailed){
                    return Center(child: Text(state.message.toString()),);
                  } else
                  return Center(child: CircularProgressIndicator());
                },
              ),




            ],
          )
        ),
      )
    );
  }

  void _loadPopularTvSeries() {
   BlocProvider.of<PopularTvSeriesCubit>(context).loadPopularTvSeries();
  }

  void _loadTopRatedTvSeries() {
    BlocProvider.of<TopRatedTvSeriesCubit>(context).loadTopRatedTvSeries();
  }

  void _loadAiringTodayTvSeries() {
    BlocProvider.of<AiringTodayTvSeriesCubit>(context).loadAiringTodayTvSeries();

  }

  void _loadTvSeriesGenres() {
    BlocProvider.of<TvSeriesGenresCubit>(context).loadTvSeriesGenres();
  }
}
