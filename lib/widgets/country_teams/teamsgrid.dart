import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_iti/data/cubits/teams_cubit/teams_cubit.dart';
import 'package:graduation_project_iti/data/cubits/teams_cubit/teams_state.dart';
import 'package:graduation_project_iti/widgets/country_teams/teamgridItem.dart';

class TeamsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<TeamsCubit, TeamsState>(
        builder: (context, state) {
          if (state is TeamsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TeamsLoaded) {
            final filteredTeams = state.filteredTeams;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                crossAxisSpacing: MediaQuery.of(context).size.width * 0.02,
                mainAxisSpacing: MediaQuery.of(context).size.width * 0.02,
              ),
              itemCount: filteredTeams.length,
              itemBuilder: (context, index) {
                final team = filteredTeams[index];
                return TeamGridItem(team: team);
              },
            );
          } else if (state is TeamsError) {
            return Center(child: Text(state.message, style: TextStyle(color: Colors.red)));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
