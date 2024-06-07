import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/top_rated_tv_series_results.dart';
import 'package:movie_app/pages/settings.dart';

part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesCubit extends Cubit<TopRatedTvSeriesState> {
  TopRatedTvSeriesCubit() : super(TopRatedTvSeriesInitial());


  final _dio = Dio();

  Future <void> loadTopRatedTvSeries() async {
    try{
      emit(TopRatedTvSeriesLoadingInProgress());

      var response = await _dio.get("${baseUrl}tv/top_rated?api_key=$apiKey");

      if(response.statusCode == 200) {

        var topRatedTvSeriesResults = TopRatedTvSeriesResults.fromJson(response.data);

        emit(TopRatedTvSeriesLoadingSucceeded(topRatedTvSeriesResults));

      } else {
        emit(TopRatedTvSeriesLoadingFailed(response.statusMessage));
      }

    } catch(e){
      emit(TopRatedTvSeriesLoadingFailed(e.toString()));
    }

  }

}
