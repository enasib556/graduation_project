import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_iti/data/cubits/teams_cubit/teams_cubit.dart';
import 'package:graduation_project_iti/data/repository/teams_repo.dart';
import 'package:graduation_project_iti/screens/teams_screen_content.dart';

class TeamsScreen extends StatelessWidget {
  final int leagueId;

  const TeamsScreen({required this.leagueId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeamsCubit(GetTeamsRepo(), leagueId)..fetchTeams(),
      child: TeamsScreenContent(leagueId: leagueId),
    );
  }
}
