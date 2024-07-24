import 'package:flutter/foundation.dart';
import 'package:graduation_project_iti/data/models/teams_model.dart';

@immutable
abstract class TeamsState {}

class TeamsInitial extends TeamsState {}

class TeamsLoading extends TeamsState {}

class TeamsLoaded extends TeamsState {
  final List<Result> teams;
  final List<Result> filteredTeams;

  TeamsLoaded({required this.teams, required this.filteredTeams});
}

class TeamsError extends TeamsState {
  final String message;

  TeamsError(this.message);
}
