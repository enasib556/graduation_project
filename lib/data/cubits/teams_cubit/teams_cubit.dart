import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_iti/data/repository/teams_repo.dart';
import 'package:graduation_project_iti/data/models/teams_model.dart';

import 'teams_state.dart';

class TeamsCubit extends Cubit<TeamsState> {
  final GetTeamsRepo _getTeamsRepo;
  final int leagueId;

  TeamsCubit(this._getTeamsRepo, this.leagueId) : super(TeamsInitial());

  void fetchTeams() async {
    emit(TeamsLoading());
    try {
      final data = await _getTeamsRepo.getTeams(leagueId);
      emit(TeamsLoaded(teams: data.result, filteredTeams: data.result));
    } catch (e) {
      emit(TeamsError('Error fetching teams: $e'));
    }
  }

  void filterTeams(String query) {
    if (state is TeamsLoaded) {
      final loadedState = state as TeamsLoaded;
      final filteredTeams = loadedState.teams
          .where((team) => team.teamName?.toLowerCase().contains(query.toLowerCase()) ?? false)
          .toList();
      emit(TeamsLoaded(teams: loadedState.teams, filteredTeams: filteredTeams));
    }
  }
}
