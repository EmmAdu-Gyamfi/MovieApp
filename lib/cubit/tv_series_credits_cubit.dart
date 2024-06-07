import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/tv_series_credit_results.dart';
import 'package:movie_app/pages/settings.dart';

part 'tv_series_credits_state.dart';

class TvSeriesCreditsCubit extends Cubit<TvSeriesCreditsState> {
  TvSeriesCreditsCubit() : super(TvSeriesCreditsInitial());

  final _dio = Dio();

  Future <void> loadTvSeriesCredits(int id) async{
    try{
      emit(TvSeriesCreditsLoadingInProgress());

      var response = await _dio.get("${baseUrl}tv/$id/credits?api_key=$apiKey");

      if(response.statusCode == 200){
        var tvSeriesCredits = TvSeriesCreditResults.fromJson(response.data);

        emit(TvSeriesCreditsLoadingSucceeded(tvSeriesCredits));
      } else{
        emit(TvSeriesCreditsLoadingFailed(response.statusMessage));
      }

    }catch(e){
      emit(TvSeriesCreditsLoadingFailed(e.toString()));
    }
  }
}
