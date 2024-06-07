import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/query_tv_series_results.dart';
import 'package:movie_app/pages/settings.dart';

part 'query_tv_series_state.dart';

class QueryTvSeriesCubit extends Cubit<QueryTvSeriesState> {
  QueryTvSeriesCubit() : super(QueryTvSeriesInitial());

  final _dio = Dio();

  Future <void> loadQueryTvSeries(String searchString) async {
    try {
      emit(QueryTvSeriesLoadingProgress());

      var response = await _dio.get(
          "${baseUrl}search/tv?api_key=$apiKey&query=$searchString");

      if (response.statusCode == 200) {
        var queryTvSeriesResults = QueryTvSeriesResults.fromJson(response.data);

        emit(QueryTvSeriesLoadingSucceeded(queryTvSeriesResults));
      } else {
        emit(QueryTvSeriesLoadingFailed(response.statusMessage));
      }
    } catch (e) {
      emit(QueryTvSeriesLoadingFailed(e.toString()));
    }
  }
}

