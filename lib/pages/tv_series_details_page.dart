import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/cubit/tv_series_credits_cubit.dart';
import 'package:movie_app/cubit/tv_series_details_cubit.dart';
import 'package:movie_app/cubit/tv_series_images_cubit.dart';
import 'package:movie_app/data/popular_tv_series.dart';
import 'package:movie_app/data/tv_series_trailers_results.dart';
import 'package:movie_app/pages/settings.dart';
import 'package:movie_app/utlis/my_dimens.dart';
import 'package:url_launcher/url_launcher.dart';

class TvSeriesDetailsPage extends StatefulWidget {
 final PopularTvSeries popularTvSeries;
  const TvSeriesDetailsPage({Key? key, required this.popularTvSeries}) : super(key: key);

  @override
  _TvSeriesDetailsPageState createState() => _TvSeriesDetailsPageState();
}

class _TvSeriesDetailsPageState extends State<TvSeriesDetailsPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTvSeriesCredits();
    _loadTvSeriesDetails();
    _loadTvSeriesImages();
  }

  @override
  Widget build(BuildContext context) {
    final _dio = Dio();
    var releasedDate = DateTime.parse(widget.popularTvSeries.firstAirDate);
    String formattedDate = DateFormat('dd MMMM, yyyy').format(releasedDate);
    if (widget.popularTvSeries.backdropPath != null) {
      return Scaffold(
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 350,
                      width: double.infinity,
                      // color: Colors.black,
                      child: Stack(
                          children: [
                            //movie backdrop
                            Positioned(
                              top: 0,
                              right: 0,
                              left: 0,
                              bottom: 0,
                              child: ClipRRect(
                                child: Image.network(
                                  "$imageBaseUrl/${widget.popularTvSeries
                                      .backdropPath}", fit: BoxFit.cover,),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                            ),

                            Container(
                              // margin: EdgeInsets.all(8.0),
                              width: double.infinity,
                              height: 350,

                              decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),

                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                height: 350,
                                width: double.infinity,
                                // color: Colors.black.withOpacity(0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30),
                                    )
                                ),

                              ),
                            ),

                            //
                            //
                            Positioned(
                              left: MyDimens.standardMargin,
                              right: MyDimens.standardMargin,
                              top: MyDimens.standardMargin,
                              bottom: MyDimens.standardMargin,

                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Stack(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(16.0),
                                          height: 250,
                                          width: 150,
                                          // color: Colors.amberAccent,
                                          child: ClipRRect(
                                            child: Image.network(
                                              "$imageBaseUrl/${widget
                                                  .popularTvSeries
                                                  .posterPath}",
                                              fit: BoxFit.fill,),
                                            borderRadius: BorderRadius.circular(
                                                20),

                                          ),
                                        ),
                                        Positioned(
                                          left: 16,
                                          top: 15,
                                          child: InkWell(
                                            onTap: () async {
                                              await youtube(_dio);
                                            },
                                            child: Container(
                                                height: 250,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(20),
                                                  // color: Colors.blue,

                                                ),
                                                child: Icon(Icons
                                                    .play_circle_outline_rounded,
                                                  color: Colors.yellow,
                                                  size: 46,)
                                            ),
                                          ),
                                        ),
                                      ]
                                  ),

                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 50),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Container(
                                            // width: 200,
                                            // height: 100,
                                            // color: Colors.amberAccent,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              widget.popularTvSeries.name,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20
                                              ),
                                            ),
                                          ),

                                          Container(
                                            // width: 200,
                                            // height: 30,
                                            // color: Colors.amberAccent,
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Rating: ${widget.popularTvSeries
                                                  .voteAverage}",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 20
                                              ),
                                            ),
                                          ),

                                          BlocBuilder<
                                              TvSeriesDetailsCubit,
                                              TvSeriesDetailsState>(

                                              builder: (context, state) {
                                                if (state is TvSeriesDetailsLoadingSucceeded) {
                                                  var genres = state
                                                      .tvSeriesDetailsResults
                                                      .genres;
                                                  return Wrap(
                                                      spacing: 8,
                                                      children: genres.map((
                                                          e) =>
                                                          ActionChip(
                                                            label: Text(e.name),
                                                            onPressed: () {},
                                                            labelStyle: GoogleFonts
                                                                .poppins(
                                                                color: Colors
                                                                    .white),
                                                            backgroundColor: Colors
                                                                .black
                                                                .withOpacity(
                                                                0.6),)).toList()

                                                  );
                                                }
                                                return Center(
                                                    child: CircularProgressIndicator());
                                              })

                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ]
                      ),
                    ),

                    //overview
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Overview", style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.9),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),),
                    ),

                    Divider(
                      height: 0,
                      endIndent: 330,
                      indent: 20,
                      thickness: 4,
                      color: Colors.black,
                    ),

                    Container(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        widget.popularTvSeries.overview,
                        style: GoogleFonts.poppins(
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                    ),

                    //release date
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "First Air Date: $formattedDate",
                        style: GoogleFonts.poppins(
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Top Billed Cast", style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.9),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),),
                    ),

                    Divider(
                      height: 0,
                      endIndent: 330,
                      indent: 20,
                      thickness: 4,
                      color: Colors.black,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        height: 260,
                        // width: 150,
                        child: BlocBuilder<
                            TvSeriesCreditsCubit,
                            TvSeriesCreditsState>(
                            builder: (context, state) {
                              if (state is TvSeriesCreditsLoadingSucceeded) {
                                var cast = state.tvSeriesCreditResults.cast;
                                return GridView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: cast.length,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisSpacing: 16,
                                        mainAxisExtent: 150

                                    ), itemBuilder: (context, index) {
                                  if (cast[index].profilePath != null) {
                                    return Container(


                                      decoration: BoxDecoration(
                                        // color: Colors.black26,
                                        // borderRadius: BorderRa dius.circular(20)
                                      ),
                                      child: Stack(
                                        children: [
                                          ClipRRect(

                                            child: Image.network(
                                              "$imageBaseUrl/${cast[index]
                                                  .profilePath}",
                                              fit: BoxFit.fill,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                20),
                                          ),

                                          Positioned(

                                            child: Container(
                                              height: 80,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,

                                                  borderRadius: BorderRadius
                                                      .only(bottomLeft: Radius
                                                      .circular(20),
                                                      bottomRight: Radius
                                                          .circular(20))
                                              ),
                                            ),
                                            bottom: 5,
                                          ),

                                          Positioned(
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 40,
                                              width: 150,
                                              // color: Colors.blue,
                                              child: Text(cast[index].character,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.adamina(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            bottom: 5,
                                          ),

                                          Positioned(
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 40,
                                              width: 150,
                                              // color: Colors.yellow,
                                              child: Text(
                                                cast[index].originalName,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            bottom: 43,
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                  else {
                                    return Container(


                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.1),
                                          // color: Colors.black26,
                                          borderRadius: BorderRadius.circular(
                                              20)
                                      ),
                                      child: Stack(
                                        children: [
                                          // ClipRRect(
                                          //
                                          //   child: Image.network(
                                          //     "$imageBaseUrl/${cast[index].profilePath}", fit: BoxFit.fill,
                                          //   ),
                                          //   borderRadius: BorderRadius.circular(20),
                                          // ),

                                          Center(child: Icon(Icons.image)),

                                          Positioned(

                                            child: Container(
                                              height: 80,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,

                                                  borderRadius: BorderRadius
                                                      .only(bottomLeft: Radius
                                                      .circular(20),
                                                      bottomRight: Radius
                                                          .circular(20))
                                              ),
                                            ),
                                            bottom: 0,
                                          ),

                                          Positioned(
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 40,
                                              width: 150,
                                              // color: Colors.blue,
                                              child: Text(cast[index].character,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.adamina(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            bottom: 5,
                                          ),

                                          Positioned(
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 40,
                                              width: 150,
                                              // color: Colors.yellow,
                                              child: Text(
                                                cast[index].originalName,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            bottom: 43,
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                });
                              }
                              return Center(child: CircularProgressIndicator());
                            }),
                      ),
                    ),

                    // screenshot

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Screenshots", style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.9),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),),
                    ),

                    Divider(
                      height: 0,
                      endIndent: 330,
                      indent: 20,
                      thickness: 4,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        height: 220,
                        // width: 150,
                        child: BlocBuilder<
                            TvSeriesImagesCubit,
                            TvSeriesImagesState>(
                            builder: (context, state) {
                              if (state is TvSeriesImagesLoadingSucceeded) {
                                var movieImages = state.tvSeriesImagesResults
                                    .backdrops;
                                return GridView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: movieImages.length,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisSpacing: 16,
                                        mainAxisExtent: 330

                                    ), itemBuilder: (context, index) {
                                  return Container(
                                    // color: Colors.yellow,
                                      child: Stack(
                                          children: [

                                            Container(
                                              margin: EdgeInsets.all(8.0),
                                              width: double.infinity,
                                              height: 217,
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin: FractionalOffset
                                                          .bottomCenter,
                                                      end: FractionalOffset
                                                          .topCenter,
                                                      colors: [
                                                        Colors.black12
                                                            .withOpacity(0.1),
                                                        Colors.white
                                                            .withOpacity(0.0),
                                                      ]
                                                  ),
                                                  borderRadius: BorderRadius
                                                      .circular(20)
                                              ),
                                            ),
                                            Positioned(

                                              child: Container(
                                                  width: double.infinity,
                                                  height: 260,
                                                  margin: EdgeInsets.all(8.0),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius
                                                        .circular(20),
                                                    child: Image.network(
                                                      "$imageBaseUrl/${movieImages[index]
                                                          .filePath}",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  )
                                              ),
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              top: 0,
                                            ),
                                          ]
                                      )
                                  );
                                }
                                );
                              }
                              return Center(child: CircularProgressIndicator());
                            }),
                      ),
                    ),


                  ]
              )
          )
      );
    } else {
      return Scaffold(
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 350,
                      width: double.infinity,
                      // color: Colors.black,
                      child: Stack(
                          children: [
                            //movie backdrop
                            Positioned(
                              top: 0,
                              right: 0,
                              left: 0,
                              bottom: 0,
                              child: ClipRRect(
                                child: Image.network(
                                  "$imageBaseUrl/${widget.popularTvSeries
                                      .posterPath}", fit: BoxFit.cover,),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                            ),

                            Container(
                              // margin: EdgeInsets.all(8.0),
                              width: double.infinity,
                              height: 350,

                              decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),

                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                height: 350,
                                width: double.infinity,
                                // color: Colors.black.withOpacity(0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30),
                                    )
                                ),

                              ),
                            ),

                            //
                            //
                            Positioned(
                              left: MyDimens.standardMargin,
                              right: MyDimens.standardMargin,
                              top: MyDimens.standardMargin,
                              bottom: MyDimens.standardMargin,

                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Stack(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(16.0),
                                          height: 250,
                                          width: 150,
                                          // color: Colors.amberAccent,
                                          child: ClipRRect(
                                            child: Image.network(
                                              "$imageBaseUrl/${widget
                                                  .popularTvSeries
                                                  .posterPath}",
                                              fit: BoxFit.fill,),
                                            borderRadius: BorderRadius.circular(
                                                20),

                                          ),
                                        ),
                                        Positioned(
                                          left: 16,
                                          top: 15,
                                          child: InkWell(
                                            onTap: () async {
                                              await youtube(_dio);
                                            },
                                            child: Container(
                                                height: 250,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(20),
                                                  // color: Colors.blue,

                                                ),
                                                child: Icon(Icons
                                                    .play_circle_outline_rounded,
                                                  color: Colors.yellow,
                                                  size: 46,)
                                            ),
                                          ),
                                        ),
                                      ]
                                  ),

                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 50),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Container(
                                            // width: 200,
                                            // height: 100,
                                            // color: Colors.amberAccent,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              widget.popularTvSeries.name,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20
                                              ),
                                            ),
                                          ),

                                          Container(
                                            // width: 200,
                                            // height: 30,
                                            // color: Colors.amberAccent,
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Rating: ${widget.popularTvSeries
                                                  .voteAverage}",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 20
                                              ),
                                            ),
                                          ),

                                          BlocBuilder<
                                              TvSeriesDetailsCubit,
                                              TvSeriesDetailsState>(

                                              builder: (context, state) {
                                                if (state is TvSeriesDetailsLoadingSucceeded) {
                                                  var genres = state
                                                      .tvSeriesDetailsResults
                                                      .genres;
                                                  return Wrap(
                                                      spacing: 8,
                                                      children: genres.map((
                                                          e) =>
                                                          ActionChip(
                                                            label: Text(e.name),
                                                            onPressed: () {},
                                                            labelStyle: GoogleFonts
                                                                .poppins(
                                                                color: Colors
                                                                    .white),
                                                            backgroundColor: Colors
                                                                .black
                                                                .withOpacity(
                                                                0.6),)).toList()

                                                  );
                                                }
                                                return Center(
                                                    child: CircularProgressIndicator());
                                              })

                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ]
                      ),
                    ),

                    //overview
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Overview", style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.9),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),),
                    ),

                    Divider(
                      height: 0,
                      endIndent: 330,
                      indent: 20,
                      thickness: 4,
                      color: Colors.black,
                    ),

                    Container(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        widget.popularTvSeries.overview,
                        style: GoogleFonts.poppins(
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                    ),

                    //release date
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "First Air Date: $formattedDate",
                        style: GoogleFonts.poppins(
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Top Billed Cast", style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.9),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),),
                    ),

                    Divider(
                      height: 0,
                      endIndent: 330,
                      indent: 20,
                      thickness: 4,
                      color: Colors.black,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        height: 260,
                        // width: 150,
                        child: BlocBuilder<
                            TvSeriesCreditsCubit,
                            TvSeriesCreditsState>(
                            builder: (context, state) {
                              if (state is TvSeriesCreditsLoadingSucceeded) {
                                var cast = state.tvSeriesCreditResults.cast;
                                return GridView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: cast.length,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisSpacing: 16,
                                        mainAxisExtent: 150

                                    ), itemBuilder: (context, index) {
                                  if (cast[index].profilePath != null) {
                                    return Container(


                                      decoration: BoxDecoration(
                                        // color: Colors.black26,
                                        // borderRadius: BorderRa dius.circular(20)
                                      ),
                                      child: Stack(
                                        children: [
                                          ClipRRect(

                                            child: Image.network(
                                              "$imageBaseUrl/${cast[index]
                                                  .profilePath}",
                                              fit: BoxFit.fill,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                20),
                                          ),

                                          Positioned(

                                            child: Container(
                                              height: 80,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,

                                                  borderRadius: BorderRadius
                                                      .only(bottomLeft: Radius
                                                      .circular(20),
                                                      bottomRight: Radius
                                                          .circular(20))
                                              ),
                                            ),
                                            bottom: 5,
                                          ),

                                          Positioned(
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 40,
                                              width: 150,
                                              // color: Colors.blue,
                                              child: Text(cast[index].character,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.adamina(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            bottom: 5,
                                          ),

                                          Positioned(
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 40,
                                              width: 150,
                                              // color: Colors.yellow,
                                              child: Text(
                                                cast[index].originalName,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            bottom: 43,
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                  else {
                                    return Container(


                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.1),
                                          // color: Colors.black26,
                                          borderRadius: BorderRadius.circular(
                                              20)
                                      ),
                                      child: Stack(
                                        children: [
                                          // ClipRRect(
                                          //
                                          //   child: Image.network(
                                          //     "$imageBaseUrl/${cast[index].profilePath}", fit: BoxFit.fill,
                                          //   ),
                                          //   borderRadius: BorderRadius.circular(20),
                                          // ),

                                          Center(child: Icon(Icons.image)),

                                          Positioned(

                                            child: Container(
                                              height: 80,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,

                                                  borderRadius: BorderRadius
                                                      .only(bottomLeft: Radius
                                                      .circular(20),
                                                      bottomRight: Radius
                                                          .circular(20))
                                              ),
                                            ),
                                            bottom: 0,
                                          ),

                                          Positioned(
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 40,
                                              width: 150,
                                              // color: Colors.blue,
                                              child: Text(cast[index].character,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.adamina(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            bottom: 5,
                                          ),

                                          Positioned(
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 40,
                                              width: 150,
                                              // color: Colors.yellow,
                                              child: Text(
                                                cast[index].originalName,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            bottom: 43,
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                });
                              }
                              return Center(child: CircularProgressIndicator());
                            }),
                      ),
                    ),

                    // screenshot

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Screenshots", style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.9),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),),
                    ),

                    Divider(
                      height: 0,
                      endIndent: 330,
                      indent: 20,
                      thickness: 4,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        height: 220,
                        // width: 150,
                        child: BlocBuilder<
                            TvSeriesImagesCubit,
                            TvSeriesImagesState>(
                            builder: (context, state) {
                              if (state is TvSeriesImagesLoadingSucceeded) {
                                var movieImages = state.tvSeriesImagesResults
                                    .backdrops;
                                return GridView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: movieImages.length,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisSpacing: 16,
                                        mainAxisExtent: 330

                                    ), itemBuilder: (context, index) {
                                  return Container(
                                    // color: Colors.yellow,
                                      child: Stack(
                                          children: [

                                            Container(
                                              margin: EdgeInsets.all(8.0),
                                              width: double.infinity,
                                              height: 217,
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin: FractionalOffset
                                                          .bottomCenter,
                                                      end: FractionalOffset
                                                          .topCenter,
                                                      colors: [
                                                        Colors.black12
                                                            .withOpacity(0.1),
                                                        Colors.white
                                                            .withOpacity(0.0),
                                                      ]
                                                  ),
                                                  borderRadius: BorderRadius
                                                      .circular(20)
                                              ),
                                            ),
                                            Positioned(

                                              child: Container(
                                                  width: double.infinity,
                                                  height: 260,
                                                  margin: EdgeInsets.all(8.0),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius
                                                        .circular(20),
                                                    child: Image.network(
                                                      "$imageBaseUrl/${movieImages[index]
                                                          .filePath}",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  )
                                              ),
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              top: 0,
                                            ),
                                          ]
                                      )
                                  );
                                }
                                );
                              }
                              return Center(child: CircularProgressIndicator());
                            }),
                      ),
                    ),


                  ]
              )
          )
      );
    }
  }

  Future<void> youtube(Dio _dio) async {
    var response = await _dio.get(
        "${baseUrl}tv/${widget.popularTvSeries.id}/videos?api_key=$apiKey");
    if (response.statusCode == 200) {
      var movieTrailers = TvSeriesTrailersResults.fromJson(response.data);
      var movieTrailersList = movieTrailers.results;
      var key = movieTrailersList![0].key;
      String url = 'https://www.youtube.com/watch?v=$key';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else {
      return;
    }
  }

  void _loadTvSeriesCredits() {
    BlocProvider.of<TvSeriesCreditsCubit>(context).loadTvSeriesCredits(
        widget.popularTvSeries.id);
  }

  void _loadTvSeriesImages() {
    BlocProvider.of<TvSeriesImagesCubit>(context).loadTvSeriesImages(
        widget.popularTvSeries.id);
  }

  void _loadTvSeriesDetails() {
    BlocProvider.of<TvSeriesDetailsCubit>(context).loadTvSeriesDetails(
        widget.popularTvSeries.id);
  }

}
