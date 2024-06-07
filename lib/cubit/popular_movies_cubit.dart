import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/popular_movies_results.dart';
import 'package:movie_app/pages/settings.dart';

part 'popular_movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(MoviesInitial());

   final _dio = Dio();

  Future <void> loadPopularMovies() async {

    try{
      emit(MoviesLoadingInProgress());
      
      var response = await _dio.get("${baseUrl}movie/popular?api_key=$apiKey");

      if(response.statusCode == 200) {

        var popularMoviesResult = PopularMoviesResults.fromJson(response.data);

        emit(MoviesLoadingSucceeded(popularMoviesResult));

      } else {
        emit(MoviesLoadingFailed(response.statusMessage));
      }

    } catch(e){
      emit(MoviesLoadingFailed(e.toString()));
    }

  }
}
