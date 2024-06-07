import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/query_movie_results.dart';
import 'package:movie_app/pages/settings.dart';

part 'query_movie_state.dart';

class QueryMovieCubit extends Cubit<QueryMovieState> {
  QueryMovieCubit() : super(QueryMovieInitial());
  final _dio = Dio();

  Future <void> loadQueryMovies(String searchString) async {
    try{
      emit(QueryMoviesLoadingProgress());

      var response = await _dio.get("${baseUrl}search/movie?api_key=$apiKey&query=$searchString");

      if(response.statusCode == 200) {

        var queryMoviesResults = QueryMoviesResults.fromJson(response.data);

        emit(QueryMoviesLoadingSucceeded(queryMoviesResults));

      } else {
        emit(QueryMoviesLoadingFailed(response.statusMessage));
      }

    } catch(e){
      emit(QueryMoviesLoadingFailed(e.toString()));
    }

  }
}
