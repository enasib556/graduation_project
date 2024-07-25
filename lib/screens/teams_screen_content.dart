import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_iti/data/cubits/teams_cubit/teams_cubit.dart';
import 'package:graduation_project_iti/widgets/country_teams/teamsgrid.dart';
import 'package:graduation_project_iti/widgets/country_teams/teamsscreenappbar.dart';
import 'package:graduation_project_iti/widgets/country_teams/teamsscreensearchbar.dart';
import 'package:graduation_project_iti/screens/topscorers_screen.dart';

class TeamsScreenContent extends StatefulWidget {
  final int leagueId;

  const TeamsScreenContent({required this.leagueId});

  @override
  _TeamsScreenContentState createState() => _TeamsScreenContentState();
}

class _TeamsScreenContentState extends State<TeamsScreenContent> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    context.read<TeamsCubit>().filterTeams(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xff222421),
        appBar: TeamsScreenAppBar(tabController: _tabController),
        body: TabBarView(
          controller: _tabController,
          children: [
            Column(
              children: [
                TeamsScreenSearchBar(searchController: _searchController),
                TeamsGrid(),
              ],
            ),
            TopScorersScreen(leagueId: widget.leagueId),
          ],
        ),
      ),
    );
  }
}
