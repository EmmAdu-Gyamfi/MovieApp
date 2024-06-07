part of 'tv_series_credits_cubit.dart';

abstract class TvSeriesCreditsState extends Equatable {
  const TvSeriesCreditsState();

  @override
  List<Object?> get props => [];
}

class TvSeriesCreditsInitial extends TvSeriesCreditsState {

}

class TvSeriesCreditsLoadingInProgress extends TvSeriesCreditsState{

}

class TvSeriesCreditsLoadingSucceeded extends TvSeriesCreditsState{
  final TvSeriesCreditResults tvSeriesCreditResults;
  const TvSeriesCreditsLoadingSucceeded(this.tvSeriesCreditResults);
  @override
  // TODO: implement props
  List<Object?> get props => [tvSeriesCreditResults];
}

class TvSeriesCreditsLoadingFailed extends TvSeriesCreditsState{
  final String? message;
  const TvSeriesCreditsLoadingFailed(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}