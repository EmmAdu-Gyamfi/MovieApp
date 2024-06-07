part of 'query_tv_series_cubit.dart';

abstract class QueryTvSeriesState extends Equatable {
  const QueryTvSeriesState();
  @override
  List<Object?> get props => [];
}

class QueryTvSeriesInitial extends QueryTvSeriesState {

}

class QueryTvSeriesLoadingProgress extends QueryTvSeriesState {

}

class QueryTvSeriesLoadingSucceeded extends QueryTvSeriesState {

  final QueryTvSeriesResults queryTvSeriesResults;

  const QueryTvSeriesLoadingSucceeded(this. queryTvSeriesResults);

  @override
  // TODO: implement props
  List<Object?> get props => [queryTvSeriesResults];
}

class QueryTvSeriesLoadingFailed extends QueryTvSeriesState {

  final String? message;

  const QueryTvSeriesLoadingFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
