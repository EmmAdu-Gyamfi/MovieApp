part of 'tv_series_details_cubit.dart';

abstract class TvSeriesDetailsState extends Equatable {
  const TvSeriesDetailsState();
  @override
  List<Object?> get props => [];
}

class TvSeriesDetailsInitial extends TvSeriesDetailsState {

}

class TvSeriesDetailsLoadingProgress extends TvSeriesDetailsState {

}

class TvSeriesDetailsLoadingSucceeded extends TvSeriesDetailsState {

  final TvSeriesDetailsResults tvSeriesDetailsResults;

  const TvSeriesDetailsLoadingSucceeded(this.tvSeriesDetailsResults);

  @override
  // TODO: implement props
  List<Object?> get props => [tvSeriesDetailsResults];
}

class TvSeriesDetailsLoadingFailed extends TvSeriesDetailsState {

  final String? message;

  const TvSeriesDetailsLoadingFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}