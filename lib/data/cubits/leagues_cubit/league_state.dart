part of 'league_cubit.dart';

@immutable
abstract class LeagueState {}

class LeagueInitial extends LeagueState {}

class LeagueLoading extends LeagueState {}

class LeagueLoaded extends LeagueState {
  final LeagueData leagueData;

  LeagueLoaded(this.leagueData);
}

class LeagueError extends LeagueState {
  final String message;

  LeagueError(this.message);
}
