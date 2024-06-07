import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/upcoming_movies_results.dart';
import 'package:movie_app/pages/settings.dart';

part 'upcoming_movies_state.dart';

class UpcomingMoviesCubit extends Cubit<UpcomingMoviesState> {
  UpcomingMoviesCubit() : super(UpcomingMoviesInitial());
  final _dio = Dio();

  Future <void> loadUpComingMovies() async {
    try{
      emit(UpcomingMoviesLoadingInProgress());

      var response = await _dio.get("${baseUrl}movie/upcoming?api_key=$apiKey");

      if(response.statusCode == 200) {

        var upComingMoviesResults = UpComingMoviesResults.fromJson(response.data);

        emit(UpcomingMoviesLoadingSucceeded(upComingMoviesResults));

      } else {
        emit(NowPlayingMoviesLoadingFailed(response.statusMessage));
      }

    } catch(e){
      emit(NowPlayingMoviesLoadingFailed(e.toString()));
    }

  }
}
