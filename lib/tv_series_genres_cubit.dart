import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_genres_state.dart';

class TvSeriesGenresCubit extends Cubit<TvSeriesGenresState> {
  TvSeriesGenresCubit() : super(TvSeriesGenresInitial());
}
