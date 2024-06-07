part of 'query_tv_series_with_genre_and_year_cubit.dart';

abstract class QueryTvSeriesWithGenreAndYearState extends Equatable {
  const QueryTvSeriesWithGenreAndYearState();
  @override
  List<Object?> get props => [];
}

class QueryTvSeriesWithGenreAndYearInitial extends QueryTvSeriesWithGenreAndYearState {
  @override
  List<Object?> get props => [];
}


class QueryTvSeriesWithGenreAndYearLoadingProgress extends QueryTvSeriesWithGenreAndYearState {

}

class QueryTvSeriesWithGenreAndYearLoadingSucceeded extends QueryTvSeriesWithGenreAndYearState {

  final QueryTvSeriesResults queryTvSeriesResults;

  const QueryTvSeriesWithGenreAndYearLoadingSucceeded(this. queryTvSeriesResults);

  @override
  // TODO: implement props
  List<Object?> get props => [queryTvSeriesResults];
}

class QueryTvSeriesWithGenreAndYearLoadingFailed extends QueryTvSeriesWithGenreAndYearState {

  final String? message;

  const QueryTvSeriesWithGenreAndYearLoadingFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}