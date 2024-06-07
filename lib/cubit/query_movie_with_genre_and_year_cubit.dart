import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/query_movie_results.dart';
import 'package:movie_app/pages/settings.dart';

part 'query_movie_with_genre_and_year_state.dart';

class QueryMovieWithGenreAndYearCubit extends Cubit<QueryMovieWithGenreAndYearState> {
  QueryMovieWithGenreAndYearCubit() : super(QueryMovieWithGenreAndYearInitial());
  final _dio = Dio();

  Future <void> loadQueryMoviesWithGenreAndYearCubit(int? genre, int? year) async {
    try{
      emit(QueryMovieWithGenreAndYearLoadingProgress());

      var response = await _dio.get("${baseUrl}discover/movie?api_key=$apiKey&with_genres=$genre&year=$year");

      if(response.statusCode == 200) {

        var queryMoviesResults = QueryMoviesResults.fromJson(response.data);

        emit(QueryMovieWithGenreAndYearLoadingSucceeded(queryMoviesResults));

      } else {
        emit(QueryMovieWithGenreAndYearLoadingFailed(response.statusMessage));
      }

    } catch(e){
      emit(QueryMovieWithGenreAndYearLoadingFailed(e.toString()));
    }

  }
}
