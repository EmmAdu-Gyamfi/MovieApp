import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/tv_series_genres.dart';
import 'package:movie_app/data/tv_series_genres_results.dart';
import 'package:movie_app/pages/settings.dart';

part 'tv_series_genres_state.dart';

class TvSeriesGenresCubit extends Cubit<TvSeriesGenresState> {
  TvSeriesGenresCubit() : super(TvSeriesGenresInitial());
  
 final _dio = Dio();
 
 Future<void> loadTvSeriesGenres() async {
   try{
     emit(TvSeriesGenresLoadingProgress());
     
     var response = await _dio.get("${baseUrl}genre/tv/list?api_key=$apiKey");

     if (response.statusCode == 200) {
       var tvSeriesGenresResults = TvSeriesGenresResults.fromJson(response.data);

       emit(TvSeriesGenresLoadingSucceeded(tvSeriesGenresResults));
     } else {
       emit(TvSeriesGenresLoadingFailed(response.statusMessage));
     }

   } catch(e){
     emit(TvSeriesGenresLoadingFailed(e.toString()));
   }
 }
}
