import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/movie_genres_results.dart';
import 'package:movie_app/pages/settings.dart';

part 'movie_genres_state.dart';

class MovieGenresCubit extends Cubit<MovieGenresState> {
  MovieGenresCubit() : super(MovieGenresInitial());

final _dio = Dio();

Future<void> loadMovieGenres() async {
  try{
    emit(MovieGenresLoadingProgress());

    var response = await _dio.get("${baseUrl}genre/movie/list?api_key=$apiKey");

    if (response.statusCode == 200) {
      var tvSeriesGenresResults = MovieGenresResults.fromJson(response.data);

      emit(MovieGenresLoadingSucceeded(tvSeriesGenresResults));
    } else {
      emit(MovieGenresLoadingFailed(response.statusMessage));
    }

  } catch(e){
    emit(MovieGenresLoadingFailed(e.toString()));
  }
}
}