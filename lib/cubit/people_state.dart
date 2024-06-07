part of 'people_cubit.dart';

abstract class PeopleState extends Equatable {
  const PeopleState();

  @override
  List<Object?> get props => [];
}

class PeopleInitial extends PeopleState {

}

class PeopleLoadingInProgress extends PeopleState {

}

class PeopleLoadingSucceeded extends PeopleState {
  final People people;
  const PeopleLoadingSucceeded(this.people);
  @override
  // TODO: implement props
    List<Object?> get props => [people];
}

class PeopleLoadingFailed extends PeopleState {
  final String message;
  const PeopleLoadingFailed(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}