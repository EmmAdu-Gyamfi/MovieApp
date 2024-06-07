part of 'tv_series_genres_cubit.dart';

abstract class TvSeriesGenresState extends Equatable {
  const TvSeriesGenresState();
  @override
  List<Object?> get props => [];
}

class TvSeriesGenresInitial extends TvSeriesGenresState {

}

class TvSeriesGenresLoadingProgress extends TvSeriesGenresState {

}

class TvSeriesGenresLoadingSucceeded extends TvSeriesGenresState {

  final TvSeriesGenresResults tvSeriesGenresResults;

  TvSeriesGenresLoadingSucceeded(this.tvSeriesGenresResults);

  @override
  // TODO: implement props
  List<Object?> get props => [tvSeriesGenresResults];

}

class TvSeriesGenresLoadingFailed extends TvSeriesGenresState {

  final String? Message;

  TvSeriesGenresLoadingFailed(this.Message);

  @override
  // TODO: implement props
  List<Object?> get props => [Message];
}
