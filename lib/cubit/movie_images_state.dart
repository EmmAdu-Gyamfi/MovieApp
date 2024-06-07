part of 'movie_images_cubit.dart';

abstract class MovieImagesState extends Equatable {
  const MovieImagesState();
  @override
  List<Object?> get props => [];
}

class MovieImagesInitial extends MovieImagesState {

}

class MovieImagesLoadingProgress extends MovieImagesState {

}

class MovieImagesLoadingSucceeded extends MovieImagesState {

  final MovieImagesResults movieImagesResults;

  const MovieImagesLoadingSucceeded(this. movieImagesResults);

  @override
  // TODO: implement props
  List<Object?> get props => [movieImagesResults];
}

class MovieImagesLoadingFailed extends MovieImagesState {

  final String? message;

  const MovieImagesLoadingFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
