part of 'query_movie_with_genre_and_year_cubit.dart';

abstract class QueryMovieWithGenreAndYearState extends Equatable {
  const QueryMovieWithGenreAndYearState();

  @override
  List<Object?> get props => [];
}

class QueryMovieWithGenreAndYearInitial extends QueryMovieWithGenreAndYearState {
  @override
  List<Object?> get props => [];
}

class QueryMovieWithGenreAndYearLoadingProgress extends QueryMovieWithGenreAndYearState {

}

class QueryMovieWithGenreAndYearLoadingSucceeded extends QueryMovieWithGenreAndYearState {

  final QueryMoviesResults queryMoviesResults;

  const QueryMovieWithGenreAndYearLoadingSucceeded(this. queryMoviesResults);

  @override
  // TODO: implement props
  List<Object?> get props => [queryMoviesResults];
}

class QueryMovieWithGenreAndYearLoadingFailed extends QueryMovieWithGenreAndYearState {

  final String? message;

  const QueryMovieWithGenreAndYearLoadingFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
