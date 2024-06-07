part of 'upcoming_movies_cubit.dart';

abstract class UpcomingMoviesState extends Equatable {
  const UpcomingMoviesState();
  @override
  List<Object?> get props => [];
}

class UpcomingMoviesInitial extends UpcomingMoviesState {

}

class UpcomingMoviesLoadingInProgress extends UpcomingMoviesState {

}

class UpcomingMoviesLoadingSucceeded extends UpcomingMoviesState {

  final UpComingMoviesResults upComingMoviesResults;

  const UpcomingMoviesLoadingSucceeded(this.upComingMoviesResults);

  @override
  // TODO: implement props
  List<Object?> get props => [upComingMoviesResults];
}

class NowPlayingMoviesLoadingFailed extends UpcomingMoviesState {

  final String? message;

  const NowPlayingMoviesLoadingFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
