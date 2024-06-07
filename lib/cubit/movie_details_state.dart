part of 'movie_details_cubit.dart';

abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();
  @override
  List<Object?> get props => [];
}

class MovieGenreInitial extends MovieDetailsState {
  @override
  List<Object?> get props => [];
}

class MovieDetailsLoadingInProgress extends MovieDetailsState {

}

class MovieDetailsLoadingSucceeded extends MovieDetailsState {

  final MovieDetailsResults movieDetailsResults;

  const MovieDetailsLoadingSucceeded(this. movieDetailsResults);

  @override
  // TODO: implement props
  List<Object?> get props => [movieDetailsResults];
}

class MovieDetailsFailed extends MovieDetailsState {

  final String? message;

  const MovieDetailsFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

