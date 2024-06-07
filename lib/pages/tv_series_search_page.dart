import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/cubit/popular_tv_series_cubit.dart';
import 'package:movie_app/cubit/query_tv_series_cubit.dart';
import 'package:movie_app/cubit/query_tv_series_with_genre_and_year_cubit.dart';
import 'package:movie_app/cubit/tv_series_genres_cubit.dart';
import 'package:movie_app/data/popular_tv_series.dart';
import 'package:movie_app/data/tv_series_genres.dart';
import 'package:movie_app/pages/settings.dart';
import 'package:movie_app/pages/tv_series_details_page.dart';


class TvSeriesSearchPage extends StatefulWidget {
  const TvSeriesSearchPage({Key? key}) : super(key: key);


  @override
  _TvSeriesSearchPageState createState() => _TvSeriesSearchPageState();
}

class _TvSeriesSearchPageState extends State<TvSeriesSearchPage> {
  List<TvSeriesGenres> genreResults = [];
  List<String> genreNameList = [];

  String? genreUserInput;
  int? yearUserInput;
  var controller = TextEditingController();
  var yearTextController = TextEditingController();
  late String userInput = "";
  int pageCounter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPopularTvSeries();
    _loadTvSeriesGenres();
  }

  @override
  Widget build(BuildContext context) {
    if (pageCounter == 0) {
      return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 16, right: 6),
                child: Container(
                  // color: Colors.grey,
                  height: 60,
                  // search bar
                  child: Row(
                    children: <Widget>[

                      Expanded(
                        child: TextField(

                          onSubmitted: (inputValue) {
                            setState(() {
                              userInput = inputValue;
                              pageCounter = 1;
                            });
                            _loadQueryTvSeries();
                          },

                          controller: controller,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.go,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                )
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15),
                            hintText: "Search for a tv show...",
                            hintStyle: GoogleFonts.poppins(),
                          ),
                        ),
                      ),
                      PopupMenuButton(
                          icon: Icon(Icons.sort),
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          itemBuilder: (context){
                            return <PopupMenuEntry>[
                              PopupMenuItem(
                                  child: Container(
                                    height: 275,
                                    width: 250,
                                    color: Colors.grey,
                                    child: Column(
                                      children:<Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Text("Filter", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),),
                                        ),

                                        BlocBuilder<TvSeriesGenresCubit, TvSeriesGenresState>(builder: (context, state){
                                          if(state is TvSeriesGenresLoadingSucceeded){

                                            genreResults = state.tvSeriesGenresResults.genres;

                                            genreResults.map((e) => genreNameList.add(e.name)).toList(growable: true);
                                          }
                                          return SizedBox();
                                        }),



                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: TextDropdownFormField(
                                            onChanged: (dynamic genre){
                                              setState(() {
                                                genreUserInput = genre.toString();
                                              });
                                            },

                                            options: genreNameList,
                                            decoration: InputDecoration(
                                                labelStyle: GoogleFonts.poppins(color: Colors.white),
                                                disabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.white),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.white),
                                                ),
                                                border: OutlineInputBorder(),
                                                suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.white),
                                                labelText: "Genre"),

                                            dropdownHeight: 220,

                                          ),
                                        ),

                                        Padding(
                                        padding: const EdgeInsets.only(top: 16.0),
                            child: TextField(
                            onChanged: (year){
                            yearUserInput = int.tryParse(year);
                            },
                            controller: yearTextController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                            labelText: "Year",
                            labelStyle: GoogleFonts.poppins(color: Colors.white),
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            ),

                            ),
                            )

                            ),

                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 16.0),
                                            child: Center(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    pageCounter = 2;
                                                  });

                                                  _loadQueryTvSeriesWithGenreAndYear();
                                                  Navigator.pop(context);


                                                },
                                                style: ButtonStyle(
                                                    fixedSize: MaterialStateProperty.all(Size(250, 50))
                                                ),
                                                child: Text("APPLY FILTER", style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
                                              ),
                                            ),
                                          ),
                                        )

                                      ],
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    ),
                                  )
                              )

                            ];
                          }
                      )

                    ],
                  ),
                ),
              ),

              // popular tv series
              Expanded(
                child: BlocBuilder<PopularTvSeriesCubit, PopularTvSeriesState>(
                  builder: (context, state) {
                    if (state is PopularTvSeriesLoadingInProgress) {
                      return Center(child: CircularProgressIndicator(),);
                    } else if (state is PopularTvSeriesLoadingSucceeded) {
                      var data = state.popularTvSeriesResults;
                      var popularTvSeries = data.results;
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16),
                              child: Text("Popular Tv Shows",
                                style: GoogleFonts.poppins(fontSize: 20,
                                    fontWeight: FontWeight.w600),),
                            ),

                            Divider(
                              height: 4,
                              endIndent: 330,
                              indent: 20,
                              thickness: 4,
                              color: Colors.black,
                            ),

                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.only(top: 16),
                                itemCount: popularTvSeries.length,

                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TvSeriesDetailsPage(
                                                      popularTvSeries: popularTvSeries[index])));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 16, right: 16, bottom: 16),
                                      // color: Colors.black26,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [

                                          Container(
                                            // margin: EdgeInsets.only(left: 8, right: 8),
                                            width: double.infinity,
                                            // height: 210,
                                            alignment: Alignment.bottomLeft,
                                            // color: Colors.amberAccent,
                                            child: Text(
                                              popularTvSeries[index].name,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),

                                            ),
                                          ),

                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Container(
                                                  width: 150,
                                                  height: 220,
                                                  // margin: EdgeInsets.all(16.0),
                                                  decoration: BoxDecoration(
                                                    // color: Colors.black,

                                                    borderRadius: BorderRadius
                                                        .circular(20),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius
                                                        .circular(20),
                                                    child: CachedNetworkImage(
                                                      imageUrl: "$imageBaseUrl/${popularTvSeries[index]
                                                          .posterPath}",
                                                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  )
                                              ),

                                              Expanded(
                                                child: Container(
                                                  // color: Colors.blue,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Container(

                                                        padding: EdgeInsets.all(
                                                            8),
                                                        child: Text(
                                                          "Released in ${popularTvSeries[index]
                                                              .firstAirDate}",
                                                          style: GoogleFonts
                                                              .poppins(
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontSize: 16),),
                                                        // color: Colors.black,
                                                        height: 40,
                                                      ),
                                                      Container(

                                                        padding: EdgeInsets.all(
                                                            8),
                                                        child: Text(
                                                          "Rating: ${popularTvSeries[index]
                                                              .voteAverage}",
                                                          style: GoogleFonts
                                                              .poppins(
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontSize: 16),),
                                                        // color: Colors.black,
                                                        height: 40,
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.all(
                                                            8),
                                                        child: Text(
                                                          "${popularTvSeries[index]
                                                              .overview}",
                                                          style: GoogleFonts
                                                              .poppins(
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontSize: 16),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 5,
                                                        ),
                                                        // color: Colors.red,
                                                        height: 170,
                                                        width: 225,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),


                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          )


      );

      // search results page
    } else if(pageCounter == 1){
      return Scaffold(
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 16, right: 6),
                child: Container(
                  height: 60,
                  // color: Colors.grey,

                  // search bar
                  child: Row(
                    children: <Widget>[

                      Expanded(
                        child: TextField(

                          onSubmitted: (inputValue) {
                            setState(() {
                              userInput = inputValue;
                              pageCounter = 1;
                            });
                            _loadQueryTvSeries();
                          },

                          controller: controller,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.go,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                )
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15),
                            hintText: "Search for a movie...",
                            hintStyle: GoogleFonts.poppins(),
                          ),
                        ),
                      ),
                      PopupMenuButton(
                          icon: Icon(Icons.sort),
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          itemBuilder: (context){
                            return <PopupMenuEntry>[
                              PopupMenuItem(
                                  child: Container(
                                    height: 275,
                                    width: 250,
                                    color: Colors.grey,
                                    child: Column(
                                      children:<Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Text("Filter", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),),
                                        ),

                                        BlocBuilder<TvSeriesGenresCubit, TvSeriesGenresState>(builder: (context, state){
                                          if(state is TvSeriesGenresLoadingSucceeded){
                                            genreResults = state.tvSeriesGenresResults.genres;
                                            genreResults.map((e) => genreNameList.add(e.name)).toList(growable: true);
                                          }
                                          return SizedBox();
                                        }),



                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: TextDropdownFormField(
                                            onChanged: (dynamic genre){
                                              setState(() {
                                                genreUserInput = genre;
                                              });
                                              _loadQueryTvSeriesWithGenreAndYear();
                                            },
                                            options: genreNameList,
                                            decoration: InputDecoration(
                                                labelStyle: GoogleFonts.poppins(color: Colors.white),
                                                disabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.white),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.white),
                                                ),
                                                border: OutlineInputBorder(),
                                                suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.white),
                                                labelText: "Genre"),

                                            dropdownHeight: 220,

                                          ),
                                        ),

                                        Padding(
                                            padding: const EdgeInsets.only(top: 16.0),
                                            child: TextField(
                                              onChanged: (year){
                                                yearUserInput = int.tryParse(year)!;
                                              },
                                              controller: yearTextController,
                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(
                                                labelText: "Year",
                                                labelStyle: GoogleFonts.poppins(color: Colors.white),
                                                border: OutlineInputBorder(),
                                                disabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.white),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.white),
                                                ),

                                              ),
                                            )

                                        ),

                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 16.0),
                                            child: Center(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    pageCounter = 2;
                                                  });

                                                  _loadQueryTvSeriesWithGenreAndYear();
                                                  Navigator.pop(context);


                                                },
                                                style: ButtonStyle(
                                                    fixedSize: MaterialStateProperty.all(Size(250, 50))
                                                ),
                                                child: Text("APPLY FILTER", style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
                                              ),
                                            ),
                                          ),
                                        )

                                      ],
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    ),
                                  )
                              )

                            ];
                          }
                      )
                    ],
                  ),
                ),
              ),

              // search results
              Expanded(
                child: BlocBuilder<QueryTvSeriesCubit, QueryTvSeriesState>(
                  builder: (context, state) {
                    if (state is QueryTvSeriesLoadingProgress) {
                      return Center(child: CircularProgressIndicator(),);
                    } else if (state is QueryTvSeriesLoadingSucceeded) {
                      var data = state.queryTvSeriesResults;
                      var queryTvSeriesList = data.results;
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16),
                              child: Text("search results for '$userInput.'",
                                style: GoogleFonts.poppins(fontSize: 16,
                                    fontWeight: FontWeight.w600),),
                            ),

                            Divider(
                              height: 4,
                              endIndent: 280,
                              indent: 20,
                              thickness: 4,
                              color: Colors.black,
                            ),
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.only(top: 16),
                                shrinkWrap: true,
                                itemCount: queryTvSeriesList.length,
                                itemBuilder: (context, index) {
                                  if (queryTvSeriesList[index].posterPath != null) {
                                    return InkWell(
                                      onTap: () {
                                        var queryTvSeries = queryTvSeriesList[index];
                                        var queryTvSeriesToDetailsPage = PopularTvSeries(backdropPath: queryTvSeries.backdropPath, firstAirDate: queryTvSeries.firstAirDate, genreIds: queryTvSeries.genreIds, id: queryTvSeries.id, name: queryTvSeries.name, originCountry: queryTvSeries.originCountry, originalLanguage: queryTvSeries.originalLanguage, originalName: queryTvSeries.originalName, overview: queryTvSeries.overview, popularity: queryTvSeries.popularity, posterPath: queryTvSeries.posterPath, voteAverage:  queryTvSeries.voteAverage, voteCount: queryTvSeries.voteCount);

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TvSeriesDetailsPage(
                                                        popularTvSeries: queryTvSeriesToDetailsPage)));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 16, right: 16, bottom: 16),
                                        // color: Colors.black26,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [

                                            Container(
                                              // margin: EdgeInsets.only(left: 8, right: 8),
                                              width: double.infinity,
                                              // height: 210,
                                              alignment: Alignment.bottomLeft,
                                              // color: Colors.amberAccent,
                                              child: Text(
                                                queryTvSeriesList[index].name,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight
                                                        .bold),

                                              ),
                                            ),

                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Container(
                                                    width: 150,
                                                    height: 220,
                                                    // margin: EdgeInsets.all(16.0),
                                                    decoration: BoxDecoration(
                                                      // color: Colors.black,

                                                      borderRadius: BorderRadius
                                                          .circular(20),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius
                                                          .circular(20),
                                                      child: Image.network(
                                                        "$imageBaseUrl/${queryTvSeriesList[index]
                                                            .posterPath}",
                                                        fit: BoxFit.fill,

                                                      ),
                                                    )
                                                ),


                                                Expanded(
                                                  child: Container(
                                                    // color: Colors.blue,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Container(

                                                          padding: EdgeInsets.all(
                                                              8),
                                                          child: Text(
                                                            "Released in ${queryTvSeriesList[index]
                                                                .firstAirDate}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: 16),),
                                                          // color: Colors.black,
                                                          height: 40,
                                                        ),
                                                        Container(

                                                          padding: EdgeInsets.all(
                                                              8),
                                                          child: Text(
                                                            "Rating: ${queryTvSeriesList[index]
                                                                .voteAverage}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: 16),),
                                                          // color: Colors.black,
                                                          height: 40,
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets.all(
                                                              8),
                                                          child: Text(
                                                            "${queryTvSeriesList[index]
                                                                .overview}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: 16),
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            maxLines: 5,
                                                          ),
                                                          // color: Colors.red,
                                                          height: 170,
                                                          width: 225,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),


                                          ],
                                        ),
                                      ),
                                    );
                                  } else if (queryTvSeriesList[index].posterPath == null) {
                                    return InkWell(
                                      onTap: () {
                                        var queryTvSeries = queryTvSeriesList[index];
                                        var queryTvSeriesToDetailsPage = PopularTvSeries(backdropPath: queryTvSeries.backdropPath, firstAirDate: queryTvSeries.firstAirDate, genreIds: queryTvSeries.genreIds, id: queryTvSeries.id, name: queryTvSeries.name, originCountry: queryTvSeries.originCountry, originalLanguage: queryTvSeries.originalLanguage, originalName: queryTvSeries.originalName, overview: queryTvSeries.overview, popularity: queryTvSeries.popularity, posterPath: queryTvSeries.posterPath, voteAverage:  queryTvSeries.voteAverage, voteCount: queryTvSeries.voteCount);

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TvSeriesDetailsPage(
                                                        popularTvSeries: queryTvSeriesToDetailsPage)));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 16, right: 16, bottom: 16),
                                        // color: Colors.black26,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [

                                            Container(
                                              // margin: EdgeInsets.only(left: 8, right: 8),
                                              width: double.infinity,
                                              // height: 210,
                                              alignment: Alignment.bottomLeft,
                                              // color: Colors.amberAccent,
                                              child: Text(
                                                queryTvSeriesList[index].name,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight
                                                        .bold),

                                              ),
                                            ),

                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Container(
                                                    width: 150,
                                                    height: 220,
                                                    // margin: EdgeInsets.all(16.0),
                                                    decoration: BoxDecoration(
                                                      // color: Colors.black,

                                                      borderRadius: BorderRadius
                                                          .circular(20),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius
                                                          .circular(20),
                                                      child: Image.network(
                                                        "$imageBaseUrl/${queryTvSeriesList[index]
                                                            .backdropPath}",
                                                        fit: BoxFit.fill,

                                                      ),
                                                    )
                                                ),

                                                Expanded(
                                                  child: Container(
                                                    // color: Colors.blue,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Container(

                                                          padding: EdgeInsets.all(
                                                              8),
                                                          child: Text(
                                                            "Released in ${queryTvSeriesList[index]
                                                                .firstAirDate}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: 16),),
                                                          // color: Colors.black,
                                                          height: 40,
                                                        ),
                                                        Container(

                                                          padding: EdgeInsets.all(
                                                              8),
                                                          child: Text(
                                                            "Rating: ${queryTvSeriesList[index]
                                                                .voteAverage}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: 16),),
                                                          // color: Colors.black,
                                                          height: 40,
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets.all(
                                                              8),
                                                          child: Text(
                                                            "${queryTvSeriesList[index]
                                                                .overview}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: 16),
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            maxLines: 5,
                                                          ),
                                                          // color: Colors.red,
                                                          height: 170,
                                                          width: 225,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),


                                          ],
                                        ),
                                      ),
                                    );
                                  } else
                                  if (queryTvSeriesList[index].backdropPath == null &&
                                      queryTvSeriesList[index].posterPath == null) {
                                    return InkWell(
                                      onTap: () {
                                        var queryTvSeries = queryTvSeriesList[index];
                                        var queryTvSeriesToDetailsPage = PopularTvSeries(backdropPath: queryTvSeries.backdropPath, firstAirDate: queryTvSeries.firstAirDate, genreIds: queryTvSeries.genreIds, id: queryTvSeries.id, name: queryTvSeries.name, originCountry: queryTvSeries.originCountry, originalLanguage: queryTvSeries.originalLanguage, originalName: queryTvSeries.originalName, overview: queryTvSeries.overview, popularity: queryTvSeries.popularity, posterPath: queryTvSeries.posterPath, voteAverage:  queryTvSeries.voteAverage, voteCount: queryTvSeries.voteCount);

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TvSeriesDetailsPage(
                                                        popularTvSeries: queryTvSeriesToDetailsPage)));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 16, right: 16, bottom: 16),
                                        // color: Colors.black26,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [

                                            Container(
                                              // margin: EdgeInsets.only(left: 8, right: 8),
                                              width: double.infinity,
                                              // height: 210,
                                              alignment: Alignment.bottomLeft,
                                              // color: Colors.amberAccent,
                                              child: Text(
                                                queryTvSeriesList[index].name,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight
                                                        .bold),

                                              ),
                                            ),

                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Container(
                                                  width: 150,
                                                  height: 220,
                                                  // margin: EdgeInsets.all(16.0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,

                                                    borderRadius: BorderRadius
                                                        .circular(20),
                                                  ),

                                                ),


                                                Expanded(
                                                  child: Container(
                                                    // color: Colors.blue,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Container(

                                                          padding: EdgeInsets.all(
                                                              8),
                                                          child: Text(
                                                            "Released in ${queryTvSeriesList[index]
                                                                .firstAirDate}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: 16),),
                                                          // color: Colors.black,
                                                          height: 40,
                                                        ),
                                                        Container(

                                                          padding: EdgeInsets.all(
                                                              8),
                                                          child: Text(
                                                            "Rating: ${queryTvSeriesList[index]
                                                                .voteAverage}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: 16),),
                                                          // color: Colors.black,
                                                          height: 40,
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets.all(
                                                              8),
                                                          child: Text(
                                                            "${queryTvSeriesList[index]
                                                                .overview}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: 16),
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            maxLines: 5,
                                                          ),
                                                          // color: Colors.red,
                                                          height: 170,
                                                          width: 225,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),


                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                }),
                          ],
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          )

        // drawer: Drawer(
        //   child: SafeArea(
        //     right: false,
        //     child: Center(
        //       child: Text('Drawer content'),
        //     ),
        //   ),
        // ),
      );
    } else {
      return Scaffold(
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 16, right: 6),
                child: Container(
                  height: 60,
                  // color: Colors.grey,

                  // search bar
                  child: Row(
                    children: <Widget>[

                      Expanded(
                        child: TextField(

                          onSubmitted: (inputValue) {
                            setState(() {
                              userInput = inputValue;
                              pageCounter = 1;
                            });
                            _loadQueryTvSeries();
                          },

                          controller: controller,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.go,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                )
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15),
                            hintText: "Search for a tv show...",
                            hintStyle: GoogleFonts.poppins(),
                          ),
                        ),
                      ),
                      PopupMenuButton(
                          icon: Icon(Icons.sort),
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          itemBuilder: (context){
                            return <PopupMenuEntry>[
                              PopupMenuItem(
                                  child: Container(
                                    height: 275,
                                    width: 250,
                                    color: Colors.grey,
                                    child: Column(
                                      children:<Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Text("Filter", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),),
                                        ),

                                        BlocBuilder<TvSeriesGenresCubit,TvSeriesGenresState>(builder: (context, state){
                                          if(state is TvSeriesGenresLoadingSucceeded){
                                            genreResults = state.tvSeriesGenresResults.genres;
                                            genreResults.map((e) => genreNameList.add(e.name)).toList(growable: true);
                                          }
                                          return SizedBox();
                                        }),



                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: TextDropdownFormField(
                                            onChanged: (dynamic genre){
                                              setState(() {
                                                genreUserInput = genre;
                                              });
                                              _loadQueryTvSeriesWithGenreAndYear();
                                            },
                                            options: genreNameList,
                                            decoration: InputDecoration(
                                                labelStyle: GoogleFonts.poppins(color: Colors.white),
                                                disabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.white),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.white),
                                                ),
                                                border: OutlineInputBorder(),
                                                suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.white),
                                                labelText: "Genre"),

                                            dropdownHeight: 220,

                                          ),
                                        ),

                                        Padding(
                                            padding: const EdgeInsets.only(top: 16.0),
                                            child: TextField(
                                              onChanged: (year){
                                                yearUserInput = int.tryParse(year)!;
                                              },
                                              controller: yearTextController,
                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(
                                                labelText: "Year",
                                                labelStyle: GoogleFonts.poppins(color: Colors.white),
                                                border: OutlineInputBorder(),
                                                disabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.white),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.white),
                                                ),

                                              ),
                                            )

                                        ),

                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 16.0),
                                            child: Center(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    pageCounter = 2;
                                                  });

                                                  _loadQueryTvSeriesWithGenreAndYear();
                                                  Navigator.pop(context);


                                                },
                                                style: ButtonStyle(
                                                    fixedSize: MaterialStateProperty.all(Size(250, 50))
                                                ),
                                                child: Text("APPLY FILTER", style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
                                              ),
                                            ),
                                          ),
                                        )

                                      ],
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    ),
                                  )
                              )

                            ];
                          }
                      )
                    ],
                  ),
                ),
              ),

              // search results for filter
              Expanded(
                child: BlocBuilder<QueryTvSeriesWithGenreAndYearCubit, QueryTvSeriesWithGenreAndYearState>(
                  builder: (context, state) {
                    if (state is QueryTvSeriesWithGenreAndYearLoadingProgress) {
                      return Center(child: CircularProgressIndicator(),);
                    } else if (state is QueryTvSeriesWithGenreAndYearLoadingSucceeded) {
                      var data = state.queryTvSeriesResults;
                      var queryMovies = data.results;
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       left: 16, right: 16),
                            //   child: Text("$yearUserInput $genreUserInput movies",
                            //     style: GoogleFonts.poppins(fontSize: 16,
                            //         fontWeight: FontWeight.w600),),
                            // ),
                            //
                            // Divider(
                            //   height: 4,
                            //   endIndent: 280,
                            //   indent: 20,
                            //   thickness: 4,
                            //   color: Colors.black,
                            // ),
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.only(top: 16),
                                shrinkWrap: true,
                                itemCount: queryMovies.length,
                                itemBuilder: (context, index) {
                                  if (queryMovies[index].posterPath != null) {
                                    return InkWell(
                                      onTap: () {
                                        var queryMovie = queryMovies[index];
                                        var queryTvSeriesToDetailsPage = PopularTvSeries(backdropPath: queryMovie.backdropPath, firstAirDate: queryMovie.firstAirDate, genreIds: queryMovie.genreIds, id: queryMovie.id, name: queryMovie.name, originCountry: queryMovie.originCountry, originalLanguage: queryMovie.originalLanguage, originalName: queryMovie.originalName, overview: queryMovie.overview, popularity: queryMovie.popularity, posterPath: queryMovie.posterPath, voteAverage: queryMovie.voteAverage, voteCount: queryMovie.voteCount);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TvSeriesDetailsPage(popularTvSeries: queryTvSeriesToDetailsPage)));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 16, right: 16, bottom: 16),
                                        // color: Colors.black26,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [

                                            Container(
                                              // margin: EdgeInsets.only(left: 8, right: 8),
                                              width: double.infinity,
                                              // height: 210,
                                              alignment: Alignment.bottomLeft,
                                              // color: Colors.amberAccent,
                                              child: Text(
                                                queryMovies[index].name,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight
                                                        .bold),

                                              ),
                                            ),

                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Container(
                                                    width: 150,
                                                    height: 220,
                                                    // margin: EdgeInsets.all(16.0),
                                                    decoration: BoxDecoration(
                                                      // color: Colors.black,

                                                      borderRadius: BorderRadius
                                                          .circular(20),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius
                                                          .circular(20),
                                                      child: Image.network(
                                                        "$imageBaseUrl/${queryMovies[index]
                                                            .posterPath}",
                                                        fit: BoxFit.fill,

                                                      ),
                                                    )
                                                ),


                                                Expanded(
                                                  child: Container(
                                                    // color: Colors.blue,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Container(

                                                          padding: EdgeInsets.all(
                                                              8),
                                                          child: Text(
                                                            "Release in ${queryMovies[index]
                                                                .firstAirDate}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: 16),),
                                                          // color: Colors.black,
                                                          height: 40,
                                                        ),
                                                        Container(

                                                          padding: EdgeInsets.all(
                                                              8),
                                                          child: Text(
                                                            "Rating: ${queryMovies[index]
                                                                .voteAverage}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: 16),),
                                                          // color: Colors.black,
                                                          height: 40,
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets.all(
                                                              8),
                                                          child: Text(
                                                            "${queryMovies[index]
                                                                .overview}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: 16),
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            maxLines: 5,
                                                          ),
                                                          // color: Colors.red,
                                                          height: 170,
                                                          width: 225,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),


                                          ],
                                        ),
                                      ),
                                    );
                                  } else if (queryMovies[index].posterPath == null) {
                                    return InkWell(
                                      onTap: () {
                                        var queryMovie = queryMovies[index];
                                        var queryTvSeriesToDetailsPage = PopularTvSeries(backdropPath: queryMovie.backdropPath, firstAirDate: queryMovie.firstAirDate, genreIds: queryMovie.genreIds, id: queryMovie.id, name: queryMovie.name, originCountry: queryMovie.originCountry, originalLanguage: queryMovie.originalLanguage, originalName: queryMovie.originalName, overview: queryMovie.overview, popularity: queryMovie.popularity, posterPath: queryMovie.posterPath, voteAverage: queryMovie.voteAverage, voteCount: queryMovie.voteCount);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TvSeriesDetailsPage(popularTvSeries: queryTvSeriesToDetailsPage)));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 16, right: 16, bottom: 16),
                                        // color: Colors.black26,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [

                                            Container(
                                              // margin: EdgeInsets.only(left: 8, right: 8),
                                              width: double.infinity,
                                              // height: 210,
                                              alignment: Alignment.bottomLeft,
                                              // color: Colors.amberAccent,
                                              child: Text(
                                                queryMovies[index].name,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight
                                                        .bold),

                                              ),
                                            ),

                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Container(
                                                    width: 150,
                                                    height: 220,
                                                    // margin: EdgeInsets.all(16.0),
                                                    decoration: BoxDecoration(
                                                      // color: Colors.black,

                                                      borderRadius: BorderRadius
                                                          .circular(20),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius
                                                          .circular(20),
                                                      child: Image.network(
                                                        "$imageBaseUrl/${queryMovies[index]
                                                            .backdropPath}",
                                                        fit: BoxFit.fill,

                                                      ),
                                                    )
                                                ),

                                                Expanded(

                                                  child: Container(
                                                    // color: Colors.blue,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Container(

                                                          padding: EdgeInsets.all(
                                                              8),
                                                          child: Text(
                                                            "Release in ${queryMovies[index]
                                                                .firstAirDate}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: 16),),
                                                          // color: Colors.black,
                                                          height: 40,
                                                        ),

                                                        Container(

                                                          padding: EdgeInsets.all(
                                                              8),
                                                          child: Text(
                                                            "Rating: ${queryMovies[index]
                                                                .voteAverage}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: 16),),
                                                          // color: Colors.black,
                                                          height: 40,
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets.all(
                                                              8),
                                                          child: Text(
                                                            "${queryMovies[index]
                                                                .overview}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: 16),
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            maxLines: 5,
                                                          ),
                                                          // color: Colors.red,
                                                          height: 170,
                                                          width: 225,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),


                                          ],
                                        ),
                                      ),
                                    );
                                  } else
                                  if (queryMovies[index].backdropPath == null &&
                                      queryMovies[index].posterPath == null) {
                                    return InkWell(
                                      onTap: () {
                                        var queryMovie = queryMovies[index];
                                        var queryTvSeriesToDetailsPage = PopularTvSeries(backdropPath: queryMovie.backdropPath, firstAirDate: queryMovie.firstAirDate, genreIds: queryMovie.genreIds, id: queryMovie.id, name: queryMovie.name, originCountry: queryMovie.originCountry, originalLanguage: queryMovie.originalLanguage, originalName: queryMovie.originalName, overview: queryMovie.overview, popularity: queryMovie.popularity, posterPath: queryMovie.posterPath, voteAverage: queryMovie.voteAverage, voteCount: queryMovie.voteCount);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TvSeriesDetailsPage(popularTvSeries: queryTvSeriesToDetailsPage)));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 16, right: 16, bottom: 16),
                                        // color: Colors.black26,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [

                                            Container(
                                              // margin: EdgeInsets.only(left: 8, right: 8),
                                              width: double.infinity,
                                              // height: 210,
                                              alignment: Alignment.bottomLeft,
                                              // color: Colors.amberAccent,
                                              child: Text(
                                                queryMovies[index].name,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight
                                                        .bold),

                                              ),
                                            ),

                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Container(
                                                  width: 150,
                                                  height: 220,
                                                  // margin: EdgeInsets.all(16.0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,

                                                    borderRadius: BorderRadius
                                                        .circular(20),
                                                  ),

                                                ),


                                                Expanded(
                                                  child: Container(
                                                    // color: Colors.blue,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Container(

                                                          padding: EdgeInsets.all(
                                                              8),
                                                          child: Text(
                                                            "Release in ${queryMovies[index]
                                                                .firstAirDate}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: 16),),
                                                          // color: Colors.black,
                                                          height: 40,
                                                        ),
                                                        Container(

                                                          padding: EdgeInsets.all(
                                                              8),
                                                          child: Text(
                                                            "Rating: ${queryMovies[index]
                                                                .voteAverage}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: 16),),
                                                          // color: Colors.black,
                                                          height: 40,
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets.all(
                                                              8),
                                                          child: Text(
                                                            "${queryMovies[index]
                                                                .overview}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: 16),
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            maxLines: 5,
                                                          ),
                                                          // color: Colors.red,
                                                          height: 170,
                                                          width: 225,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),


                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                }),
                          ],
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          )

        // drawer: Drawer(
        //   child: SafeArea(
        //     right: false,
        //     child: Center(
        //       child: Text('Drawer content'),
        //     ),
        //   ),
        // ),
      );
    }
  }

  void _loadQueryTvSeries() {
    BlocProvider.of<QueryTvSeriesCubit>(context).loadQueryTvSeries(userInput);
  }

  void _loadPopularTvSeries() {
    BlocProvider.of<PopularTvSeriesCubit>(context).loadPopularTvSeries();
  }

  void _loadTvSeriesGenres() {
    BlocProvider.of<TvSeriesGenresCubit>(context).loadTvSeriesGenres();
  }



  void _loadQueryTvSeriesWithGenreAndYear() {
    var k = genreResults.where((e) => e.name == genreUserInput).toList();
    if(k.isNotEmpty){
      var genreId = k[0].id;
      BlocProvider.of<QueryTvSeriesWithGenreAndYearCubit>(context).loadQueryTvSeriesWithGenreAndYearCubit(genreId, yearUserInput);
    } else{
      int? nullInt;
      BlocProvider.of<QueryTvSeriesWithGenreAndYearCubit>(context).loadQueryTvSeriesWithGenreAndYearCubit(nullInt, yearUserInput);
    }

  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);




}



