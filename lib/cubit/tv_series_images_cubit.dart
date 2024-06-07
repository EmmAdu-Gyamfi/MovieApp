import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/tv_series_images_results.dart';
import 'package:movie_app/pages/settings.dart';

part 'tv_series_images_state.dart';

class TvSeriesImagesCubit extends Cubit<TvSeriesImagesState> {
  TvSeriesImagesCubit() : super(TvSeriesImagesInitial());

  final _dio = Dio();

  Future <void> loadTvSeriesImages(int id) async {
    try{
      emit(TvSeriesImagesLoadingProgress());

      var response = await _dio.get("${baseUrl}tv/$id/images?api_key=$apiKey");

      if(response.statusCode == 200) {

        var tvSeriesImagesResults = TvSeriesImagesResults.fromJson(response.data);

        emit(TvSeriesImagesLoadingSucceeded(tvSeriesImagesResults));

      } else {
        emit(TvSeriesImagesLoadingFailed(response.statusMessage));
      }

    } catch(e){
      emit(TvSeriesImagesLoadingFailed(e.toString()));
    }

  }
}
