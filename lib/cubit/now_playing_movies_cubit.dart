import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/now_playing_movies_results.dart';
import 'package:movie_app/pages/settings.dart';

part 'now_playing_movies_state.dart';

class NowPlayingMoviesCubit extends Cubit<NowPlayingMoviesState> {
  NowPlayingMoviesCubit() : super(NowPlayingMoviesInitial());
  final _dio = Dio();

  Future <void> loadNowPlayingMovies() async {

    try{
      emit(NowPlayingMoviesLoadingInProgress());

      var response = await _dio.get("${baseUrl}movie/now_playing?api_key=$apiKey");

      if(response.statusCode == 200) {

        var nowPlayingMoviesResult = NowPlayingMoviesResults.fromJson(response.data);

        emit(NowPlayingMoviesLoadingSucceeded(nowPlayingMoviesResult));

      } else {
        emit(NowPlayingMoviesLoadingFailed(response.statusMessage));
      }

    } catch(e){
      emit(NowPlayingMoviesLoadingFailed(e.toString()));
    }

  }
}
