import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/airing_today_tv_series_results.dart';
import 'package:movie_app/pages/settings.dart';

part 'airing_today_tv_series_state.dart';

class AiringTodayTvSeriesCubit extends Cubit<AiringTodayTvSeriesState> {
  AiringTodayTvSeriesCubit() : super(AiringTodayTvSeriesInitial());

  final _dio = Dio();

  Future <void> loadAiringTodayTvSeries() async {
    try{
      emit(AiringTodayTvSeriesLoadingInProgress());

      var response = await _dio.get("${baseUrl}tv/airing_today?api_key=$apiKey");

      if(response.statusCode == 200) {

        var airingTodayTvSeriesResults = AiringTodayTvSeriesResults.fromJson(response.data);

        emit(AiringTodayTvSeriesLoadingSucceeded(airingTodayTvSeriesResults));

      } else {
        emit(AiringTodayTvSeriesLoadingFailed(response.statusMessage));
      }

    } catch(e){
      emit(AiringTodayTvSeriesLoadingFailed(e.toString()));
    }

  }
}
