part of 'now_playing_movies_cubit.dart';

abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();
  @override
  List<Object?> get props => [];
}

class NowPlayingMoviesInitial extends NowPlayingMoviesState {

}
class NowPlayingMoviesLoadingInProgress extends NowPlayingMoviesState {

}

class NowPlayingMoviesLoadingSucceeded extends NowPlayingMoviesState {

  final NowPlayingMoviesResults nowPlayingMoviesResults;

  const NowPlayingMoviesLoadingSucceeded(this.nowPlayingMoviesResults);

  @override
  // TODO: implement props
  List<Object?> get props => [nowPlayingMoviesResults];
}

class NowPlayingMoviesLoadingFailed extends NowPlayingMoviesState {

  final String? message;

  const NowPlayingMoviesLoadingFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
