part of 'similar_movies_cubit.dart';

abstract class SimilarMoviesState extends Equatable {
  const SimilarMoviesState();
  @override
  List<Object?> get props => [];
}

class SimilarMoviesInitial extends SimilarMoviesState {

}

class SimilarMoviesLoadingProgress extends SimilarMoviesState {

}

class SimilarMoviesLoadingSucceeded extends SimilarMoviesState {

  final SimilarMoviesResults similarMoviesResults;

  const SimilarMoviesLoadingSucceeded(this. similarMoviesResults);

  @override
  // TODO: implement props
  List<Object?> get props => [similarMoviesResults];
}

class SimilarMoviesLoadingFailed extends SimilarMoviesState {

  final String? message;

  const SimilarMoviesLoadingFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}