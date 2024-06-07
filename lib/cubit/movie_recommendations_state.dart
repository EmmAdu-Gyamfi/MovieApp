part of 'movie_recommendations_cubit.dart';

abstract class MovieRecommendationsState extends Equatable {
  const MovieRecommendationsState();

  @override
  List<Object?> get props => [];
}

class MovieRecommendationsInitial extends MovieRecommendationsState {

}

class  MovieRecommendationsLoadingProgress extends MovieRecommendationsState {

}

class  MovieRecommendationsLoadingSucceeded extends MovieRecommendationsState {

  final MovieRecommendationsResults movieRecommendationsResults;

  const  MovieRecommendationsLoadingSucceeded(this. movieRecommendationsResults);

  @override
  // TODO: implement props
  List<Object?> get props => [movieRecommendationsResults];
}

class  MovieRecommendationsLoadingFailed extends MovieRecommendationsState {

  final String? message;

  const  MovieRecommendationsLoadingFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
