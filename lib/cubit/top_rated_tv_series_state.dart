part of 'top_rated_tv_series_cubit.dart';

abstract class TopRatedTvSeriesState extends Equatable {
  const TopRatedTvSeriesState();
  @override
  List<Object?> get props => [];
}

class TopRatedTvSeriesInitial extends TopRatedTvSeriesState {

}

class TopRatedTvSeriesLoadingInProgress extends TopRatedTvSeriesState {

}

class TopRatedTvSeriesLoadingSucceeded extends TopRatedTvSeriesState {

  final TopRatedTvSeriesResults topRatedTvSeriesResults;

  const TopRatedTvSeriesLoadingSucceeded(this.topRatedTvSeriesResults);

  @override
  // TODO: implement props
  List<Object?> get props => [topRatedTvSeriesResults];
}

class TopRatedTvSeriesLoadingFailed extends TopRatedTvSeriesState {

  final String? message;

  const TopRatedTvSeriesLoadingFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
