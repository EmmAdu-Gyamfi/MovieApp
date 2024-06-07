import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/top_rated_movies_results.dart';
import 'package:movie_app/pages/settings.dart';

part 'top_rated_movies_state.dart';

class TopRatedMoviesCubit extends Cubit<TopRatedMoviesState> {
  TopRatedMoviesCubit() : super(TopRatedMoviesInitial());
  final _dio = Dio();

  Future <void> loadTopRatedMovies() async {
    try{
      emit(TopRatedMoviesLoadingInProgress());

      var response = await _dio.get("${baseUrl}movie/top_rated?api_key=$apiKey");

      if(response.statusCode == 200) {

        var topRatedMoviesResults = TopRatedMoviesResults.fromJson(response.data);

        emit(TopRatedMoviesLoadingSucceeded(topRatedMoviesResults));

      } else {
        emit(TopRatedMoviesLoadingFailed(response.statusMessage));
      }

    } catch(e){
      emit(TopRatedMoviesLoadingFailed(e.toString()));
    }

  }
}
