import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/tv_series_details_results.dart';
import 'package:movie_app/pages/settings.dart';

part 'tv_series_details_state.dart';

class TvSeriesDetailsCubit extends Cubit<TvSeriesDetailsState> {
  TvSeriesDetailsCubit() : super(TvSeriesDetailsInitial());
  
  final _dio = Dio();
  
  Future<void> loadTvSeriesDetails (int id) async{
    try{
      emit(TvSeriesDetailsLoadingProgress());

      var response = await _dio.get("${baseUrl}tv/$id?api_key=$apiKey");

      if(response.statusCode == 200) {
        var tvSeriesDetailsResults = TvSeriesDetailsResults.fromJson(response.data);
        emit(TvSeriesDetailsLoadingSucceeded(tvSeriesDetailsResults));
      } else {
        emit(TvSeriesDetailsLoadingFailed(response.statusMessage));
      }



    } catch (e){
      emit(TvSeriesDetailsLoadingFailed(e.toString()));
    }

  }
}
