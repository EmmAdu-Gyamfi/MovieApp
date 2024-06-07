import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/popular_tv_series_result.dart';
import 'package:movie_app/pages/settings.dart';

part 'popular_tv_series_state.dart';

class PopularTvSeriesCubit extends Cubit<PopularTvSeriesState> {
  PopularTvSeriesCubit() : super(PopularTvSeriesInitial());

  final _dio = Dio();

  Future <void> loadPopularTvSeries() async {
    try{
      emit(PopularTvSeriesLoadingInProgress());

      var response = await _dio.get("${baseUrl}tv/popular?api_key=$apiKey");

      if(response.statusCode == 200) {

        var popularTvSeriesResults = PopularTvSeriesResults.fromJson(response.data);

        emit(PopularTvSeriesLoadingSucceeded(popularTvSeriesResults));

      } else {
        emit(PopularTvSeriesLoadingFailed(response.statusMessage));
      }

    } catch(e){
      emit(PopularTvSeriesLoadingFailed(e.toString()));
    }

  }
}
