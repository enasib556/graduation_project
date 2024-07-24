import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project_iti/data/models/topscorers_model.dart';
import 'package:graduation_project_iti/data/repository/topscorers_repo.dart';
import 'package:graduation_project_iti/data/cubits/topscorers_cubit/topscorers_cubit.dart';

class TopScorersScreen extends StatelessWidget {
  final int leagueId;

  TopScorersScreen({required this.leagueId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopScorersCubit(GetTopscorersRepo(), leagueId)..fetchTopScorers(),
      child: Scaffold(
        backgroundColor: Color(0xff222421),
        appBar: AppBar(
          backgroundColor: Color(0xff1B1B1B),
          title: Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Row(
              children: [
                Text(
                  " Top",
                  style: GoogleFonts.montserrat(
                      fontStyle: FontStyle.italic,
                      color: Color(0xffFFFFFF),
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.05), // Responsive font size
                ),
                Text("Scorers",
                    style: GoogleFonts.montserrat(
                      fontStyle: FontStyle.italic,
                      color: Color(0xff6ABE66),
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.05)), // Responsive font size
              ],
            ),
          ),
        ),
        body: BlocBuilder<TopScorersCubit, TopScorersState>(
          builder: (context, state) {
            if (state is TopScorersLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TopScorersLoaded) {
              final topScorers = state.topScorers.result;
              return ListView.builder(
                itemCount: topScorers.length,
                itemBuilder: (context, index) {
                  final scorer = topScorers[index];
                  return ListTile(
                    title: Text(
                      scorer.playerName,
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    subtitle: Text(
                      '${scorer.teamName} - ${scorer.goals} goals',
                      style: GoogleFonts.montserrat(color: Color(0xff6ABE66)),
                    ),
                  );
                },
              );
            } else if (state is TopScorersError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
