part of 'movie_genres_cubit.dart';

abstract class MovieGenresState extends Equatable {
  const MovieGenresState();
  @override
  List<Object?> get props => [];
}

class MovieGenresInitial extends MovieGenresState {

}

class MovieGenresLoadingProgress extends MovieGenresState {

}

class MovieGenresLoadingSucceeded extends MovieGenresState {

  final MovieGenresResults tvSeriesGenresResults;

  MovieGenresLoadingSucceeded(this.tvSeriesGenresResults);

  @override
  // TODO: implement props
  List<Object?> get props => [tvSeriesGenresResults];

}

class MovieGenresLoadingFailed extends MovieGenresState {

  final String? Message;

  MovieGenresLoadingFailed(this.Message);

  @override
  // TODO: implement props
  List<Object?> get props => [Message];
}
