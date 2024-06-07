part of 'movie_credit_cubit.dart';

abstract class MovieCreditState extends Equatable {
  const MovieCreditState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MovieCreditInitial extends MovieCreditState {

}

class MovieCreditLoadingProgress extends MovieCreditState {

}

class MovieCreditLoadingSucceeded extends MovieCreditState {

  final MovieCreditResults movieCreditResults;

  const MovieCreditLoadingSucceeded(this. movieCreditResults);

  @override
  // TODO: implement props
  List<Object?> get props => [movieCreditResults];
}

class MovieCreditLoadingFailed extends MovieCreditState {

  final String? message;

  const MovieCreditLoadingFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
