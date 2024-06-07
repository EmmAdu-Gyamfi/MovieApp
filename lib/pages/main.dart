import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubit/airing_today_tv_series_cubit.dart';
import 'package:movie_app/cubit/movie_credit_cubit.dart';
import 'package:movie_app/cubit/movie_details_cubit.dart';
import 'package:movie_app/cubit/movie_genres_cubit.dart';
import 'package:movie_app/cubit/movie_images_cubit.dart';
import 'package:movie_app/cubit/movie_recommendations_cubit.dart';
import 'package:movie_app/cubit/movie_trailers_cubit.dart';
import 'package:movie_app/cubit/now_playing_movies_cubit.dart';
import 'package:movie_app/cubit/popular_tv_series_cubit.dart';
import 'package:movie_app/cubit/query_movie_cubit.dart';
import 'package:movie_app/cubit/query_movie_with_genre_and_year_cubit.dart';
import 'package:movie_app/cubit/query_tv_series_cubit.dart';
import 'package:movie_app/cubit/query_tv_series_with_genre_and_year_cubit.dart';
import 'package:movie_app/cubit/similar_movies_cubit.dart';
import 'package:movie_app/cubit/top_rated_movies_cubit.dart';
import 'package:movie_app/cubit/top_rated_tv_series_cubit.dart';
import 'package:movie_app/cubit/tv_series_credits_cubit.dart';
import 'package:movie_app/cubit/tv_series_details_cubit.dart';
import 'package:movie_app/cubit/tv_series_genres_cubit.dart';
import 'package:movie_app/cubit/tv_series_images_cubit.dart';
import 'package:movie_app/cubit/upcoming_movies_cubit.dart';

import '../cubit/people_cubit.dart';
import '../cubit/popular_movies_cubit.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

        providers: [
          BlocProvider<MoviesCubit>(
            create: (context) => MoviesCubit(),
          ),
          BlocProvider<MovieDetailsCubit>(

            create: (context) => MovieDetailsCubit(),
          ),
          BlocProvider<MovieCreditCubit>(
              create: (context) => MovieCreditCubit()),

          BlocProvider<SimilarMoviesCubit>(
              create: (context) => SimilarMoviesCubit()),

          BlocProvider<NowPlayingMoviesCubit>(
              create: (context) => NowPlayingMoviesCubit()),

          BlocProvider<UpcomingMoviesCubit>(
              create: (context) => UpcomingMoviesCubit()),

          BlocProvider<TopRatedMoviesCubit>(
              create: (context) => TopRatedMoviesCubit()),

          BlocProvider<PopularTvSeriesCubit>(
              create: (context) => PopularTvSeriesCubit()),

          BlocProvider<TopRatedTvSeriesCubit>(
              create: (context) => TopRatedTvSeriesCubit()),

          BlocProvider<AiringTodayTvSeriesCubit>(
              create: (context) => AiringTodayTvSeriesCubit()),

          BlocProvider<TvSeriesCreditsCubit>(
              create: (context) => TvSeriesCreditsCubit()),

          BlocProvider<MovieRecommendationsCubit>(
              create: (context) => MovieRecommendationsCubit()),

          BlocProvider<TvSeriesDetailsCubit>(
              create: (context) => TvSeriesDetailsCubit()),

          BlocProvider<TvSeriesGenresCubit>(
              create: (context) => TvSeriesGenresCubit()),

          BlocProvider<MovieImagesCubit>(
              create: (context) => MovieImagesCubit()),

          BlocProvider<TvSeriesImagesCubit>(
              create: (context) => TvSeriesImagesCubit()),

          BlocProvider<MovieTrailersCubit>(
              create: (context) => MovieTrailersCubit()),

          BlocProvider<QueryMovieCubit>(
              create: (context) => QueryMovieCubit()),

          BlocProvider<MovieGenresCubit>(
              create: (context) => MovieGenresCubit()),

          BlocProvider<QueryTvSeriesCubit>(
              create: (context) => QueryTvSeriesCubit()),

          BlocProvider<QueryMovieWithGenreAndYearCubit>(
              create: (context) => QueryMovieWithGenreAndYearCubit()),

          BlocProvider<QueryTvSeriesWithGenreAndYearCubit>(
              create: (context) => QueryTvSeriesWithGenreAndYearCubit()),

          BlocProvider<PeopleCubit>(
              create: (context) => PeopleCubit()),


        ],

      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blueGrey,
        ),
        home: const HomePage(),
        ),
        // home: BlocProvider(
        //   create: (context) => MoviesCubit(),
        //   child: const HomePage(),
        // )


    );
  }
}



