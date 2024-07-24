part of 'topscorers_cubit.dart';

abstract class TopScorersState extends Equatable {
  const TopScorersState();

  @override
  List<Object> get props => [];
}

class TopScorersInitial extends TopScorersState {}

class TopScorersLoading extends TopScorersState {}

class TopScorersLoaded extends TopScorersState {
  final GetTopscorersModel topScorers;

  const TopScorersLoaded(this.topScorers);

  @override
  List<Object> get props => [topScorers];
}

class TopScorersError extends TopScorersState {
  final String message;

  const TopScorersError(this.message);

  @override
  List<Object> get props => [message];
}
