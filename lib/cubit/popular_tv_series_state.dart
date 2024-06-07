part of 'popular_tv_series_cubit.dart';

abstract class PopularTvSeriesState extends Equatable {
  const PopularTvSeriesState();
  @override
  List<Object?> get props => [];
}

class PopularTvSeriesInitial extends PopularTvSeriesState {

}

class PopularTvSeriesLoadingInProgress extends PopularTvSeriesState {

}

class PopularTvSeriesLoadingSucceeded extends PopularTvSeriesState {

  final PopularTvSeriesResults popularTvSeriesResults;

  const PopularTvSeriesLoadingSucceeded(this.popularTvSeriesResults);

  @override
  // TODO: implement props
  List<Object?> get props => [popularTvSeriesResults];
}

class PopularTvSeriesLoadingFailed extends PopularTvSeriesState {

  final String? message;

  const PopularTvSeriesLoadingFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}