part of 'tv_series_images_cubit.dart';

abstract class TvSeriesImagesState extends Equatable {
  const TvSeriesImagesState();
  @override
  List<Object?> get props => [];
}

class TvSeriesImagesInitial extends TvSeriesImagesState {

}


class TvSeriesImagesLoadingProgress extends TvSeriesImagesState {

}

class TvSeriesImagesLoadingSucceeded extends TvSeriesImagesState {

  final TvSeriesImagesResults tvSeriesImagesResults;

  const TvSeriesImagesLoadingSucceeded(this. tvSeriesImagesResults);

  @override
  // TODO: implement props
  List<Object?> get props => [tvSeriesImagesResults];
}

class TvSeriesImagesLoadingFailed extends TvSeriesImagesState {

  final String? message;

  const TvSeriesImagesLoadingFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}