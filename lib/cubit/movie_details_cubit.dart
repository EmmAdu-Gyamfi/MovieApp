import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/movies_details_results.dart';
import 'package:movie_app/pages/settings.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit() : super(MovieGenreInitial());

  final _dio = Dio();

  Future <void> loadMovieDetails(int id) async {

    try{
      emit(MovieDetailsLoadingInProgress());

      var response = await _dio.get("${baseUrl}movie/$id?api_key=$apiKey");

      if(response.statusCode == 200) {

        var movieGenreResult = MovieDetailsResults.fromJson(response.data);

        emit(MovieDetailsLoadingSucceeded(movieGenreResult));

      } else {
        emit(MovieDetailsFailed(response.statusMessage));
      }

    } catch(e){
      emit(MovieDetailsFailed(e.toString()));
    }

  }
}
