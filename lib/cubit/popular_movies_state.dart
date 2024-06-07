part of 'popular_movies_cubit.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MoviesInitial extends MoviesState {

}

class MoviesLoadingInProgress extends MoviesState {

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MoviesLoadingSucceeded extends MoviesState {

  final PopularMoviesResults popularMoviesResults;

  const MoviesLoadingSucceeded(this.popularMoviesResults);

  @override
  // TODO: implement props
  List<Object?> get props => [popularMoviesResults];
}

class MoviesLoadingFailed extends MoviesState {

  final String? message;

  const MoviesLoadingFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}