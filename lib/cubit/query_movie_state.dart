part of 'query_movie_cubit.dart';

abstract class QueryMovieState extends Equatable {
  const QueryMovieState();
  @override
  List<Object?> get props => [];
}

class QueryMovieInitial extends QueryMovieState {

}

class QueryMoviesLoadingProgress extends QueryMovieState {

}

class QueryMoviesLoadingSucceeded extends QueryMovieState {

  final QueryMoviesResults queryMoviesResults;

  const QueryMoviesLoadingSucceeded(this. queryMoviesResults);

  @override
  // TODO: implement props
  List<Object?> get props => [queryMoviesResults];
}

class QueryMoviesLoadingFailed extends QueryMovieState {

  final String? message;

  const QueryMoviesLoadingFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
