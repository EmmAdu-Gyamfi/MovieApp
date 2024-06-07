part of 'top_rated_movies_cubit.dart';

abstract class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();
  @override
  List<Object?> get props => [];
}

class TopRatedMoviesInitial extends TopRatedMoviesState {

}

class TopRatedMoviesLoadingInProgress extends TopRatedMoviesState {

}

class TopRatedMoviesLoadingSucceeded extends TopRatedMoviesState {

  final TopRatedMoviesResults topRatedMoviesResults;

  const TopRatedMoviesLoadingSucceeded(this.topRatedMoviesResults);

  @override
  // TODO: implement props
  List<Object?> get props => [topRatedMoviesResults];
}

class TopRatedMoviesLoadingFailed extends TopRatedMoviesState {

  final String? message;

  const TopRatedMoviesLoadingFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
