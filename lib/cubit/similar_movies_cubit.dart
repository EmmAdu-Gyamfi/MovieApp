import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/similar_movies_results.dart';
import 'package:movie_app/pages/settings.dart';

part 'similar_movies_state.dart';

class SimilarMoviesCubit extends Cubit<SimilarMoviesState> {
  SimilarMoviesCubit() : super(SimilarMoviesInitial());
  final _dio = Dio();

  Future <void> loadSimilarMovies(int id) async {
    try{
      emit(SimilarMoviesLoadingProgress());

      var response = await _dio.get("${baseUrl}movie/$id/similar?api_key=$apiKey");

      if(response.statusCode == 200) {

        var similarMoviesResults = SimilarMoviesResults.fromJson(response.data);

        emit(SimilarMoviesLoadingSucceeded(similarMoviesResults));

      } else {
        emit(SimilarMoviesLoadingFailed(response.statusMessage));
      }

    } catch(e){
      emit(SimilarMoviesLoadingFailed(e.toString()));
    }

  }
}
