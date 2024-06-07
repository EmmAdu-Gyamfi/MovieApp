import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/movie_credit_results.dart';
import 'package:movie_app/pages/settings.dart';

part 'movie_credit_state.dart';

class MovieCreditCubit extends Cubit<MovieCreditState> {
  MovieCreditCubit() : super(MovieCreditInitial());

  final _dio = Dio();

  Future <void> loadMovieCredit(int id) async {
    try{
      emit(MovieCreditLoadingProgress());

      var response = await _dio.get("${baseUrl}movie/$id/credits?api_key=$apiKey");

      if(response.statusCode == 200) {

        var movieCreditResult = MovieCreditResults.fromJson(response.data);

        emit(MovieCreditLoadingSucceeded(movieCreditResult));

      } else {
        emit(MovieCreditLoadingFailed(response.statusMessage));
      }

    } catch(e){
      emit(MovieCreditLoadingFailed(e.toString()));
    }

  }

}
