part of 'movie_trailers_cubit.dart';

abstract class MovieTrailersState extends Equatable {
  const MovieTrailersState();
  @override
  List<Object?> get props => [];
}

class MovieTrailersInitial extends MovieTrailersState {

}


class MovieTrailersLoadingProgress extends MovieTrailersState {

}

class MovieTrailersLoadingSucceeded extends MovieTrailersState {

  final MovieTrailersResults movieTrailersResults;

  const MovieTrailersLoadingSucceeded(this. movieTrailersResults);

  @override
  // TODO: implement props
  List<Object?> get props => [movieTrailersResults];
}

class MovieTrailersLoadingFailed extends MovieTrailersState {

  final String? message;

  const MovieTrailersLoadingFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
