part of 'airing_today_tv_series_cubit.dart';

abstract class AiringTodayTvSeriesState extends Equatable {
  const AiringTodayTvSeriesState();
  @override
  List<Object?> get props => [];
}

class AiringTodayTvSeriesInitial extends AiringTodayTvSeriesState {

}

class AiringTodayTvSeriesLoadingInProgress extends AiringTodayTvSeriesState {

}

class AiringTodayTvSeriesLoadingSucceeded extends AiringTodayTvSeriesState {

  final AiringTodayTvSeriesResults airingTodayTvSeriesResults;

  const AiringTodayTvSeriesLoadingSucceeded(this.airingTodayTvSeriesResults);

  @override
  // TODO: implement props
  List<Object?> get props => [airingTodayTvSeriesResults];
}

class AiringTodayTvSeriesLoadingFailed extends AiringTodayTvSeriesState {

  final String? message;

  const AiringTodayTvSeriesLoadingFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
