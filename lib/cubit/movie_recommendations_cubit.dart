import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/movie_recommendations_results.dart';
import 'package:movie_app/pages/settings.dart';

part 'movie_recommendations_state.dart';

class MovieRecommendationsCubit extends Cubit<MovieRecommendationsState> {
  MovieRecommendationsCubit() : super(MovieRecommendationsInitial());
  final _dio = Dio();
  Future <void> loadRecommendedMovies(int id) async {
    try{
      emit(MovieRecommendationsLoadingProgress());

      var response = await _dio.get("${baseUrl}movie/$id/recommendations?api_key=$apiKey");

      if(response.statusCode == 200) {

        var movieRecommendationsResults = MovieRecommendationsResults.fromJson(response.data);

        emit(MovieRecommendationsLoadingSucceeded(movieRecommendationsResults));

      } else {
        emit(MovieRecommendationsLoadingFailed(response.statusMessage));
      }

    } catch(e){
      emit(MovieRecommendationsLoadingFailed(e.toString()));
    }

  }
}
