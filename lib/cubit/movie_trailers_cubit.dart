import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/movie_trailers_results.dart';
import 'package:movie_app/pages/settings.dart';

part 'movie_trailers_state.dart';

class MovieTrailersCubit extends Cubit<MovieTrailersState> {
  MovieTrailersCubit() : super(MovieTrailersInitial());
  final _dio = Dio();

  Future <void> loadMovieTrailers(int id) async {
    try{
      emit(MovieTrailersLoadingProgress());

      var response = await _dio.get("${baseUrl}movie/$id/videos?api_key=$apiKey");

      if(response.statusCode == 200) {

        var movieTrailersResults = MovieTrailersResults.fromJson(response.data);

        emit(MovieTrailersLoadingSucceeded(movieTrailersResults));

      } else {
        emit(MovieTrailersLoadingFailed(response.statusMessage));
      }

    } catch(e){
      emit(MovieTrailersLoadingFailed(e.toString()));
    }

  }
}
