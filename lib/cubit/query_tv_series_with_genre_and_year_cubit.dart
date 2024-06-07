import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/query_tv_series_results.dart';
import 'package:movie_app/pages/settings.dart';

part 'query_tv_series_with_genre_and_year_state.dart';

class QueryTvSeriesWithGenreAndYearCubit extends Cubit<QueryTvSeriesWithGenreAndYearState> {
  QueryTvSeriesWithGenreAndYearCubit() : super(QueryTvSeriesWithGenreAndYearInitial());
  final _dio = Dio();

  Future <void> loadQueryTvSeriesWithGenreAndYearCubit(int? genre, int? year) async {
    try{
      emit(QueryTvSeriesWithGenreAndYearLoadingProgress());

      var response = await _dio.get("${baseUrl}discover/tv?api_key=$apiKey&with_genres=$genre&first_air_date_year=$year");

      if(response.statusCode == 200) {

        var queryTvSeriesResults = QueryTvSeriesResults.fromJson(response.data);

        emit(QueryTvSeriesWithGenreAndYearLoadingSucceeded(queryTvSeriesResults));

      } else {
        emit(QueryTvSeriesWithGenreAndYearLoadingFailed(response.statusMessage));
      }

    } catch(e){
      emit(QueryTvSeriesWithGenreAndYearLoadingFailed(e.toString()));
    }

  }
}
