import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project_iti/data/models/topscorers_model.dart';
import 'package:graduation_project_iti/data/repository/topscorers_repo.dart';

class TopScorersScreen extends StatefulWidget {
  final int leagueId;

  TopScorersScreen({required this.leagueId});

  @override
  _TopScorersScreenState createState() => _TopScorersScreenState();
}

class _TopScorersScreenState extends State<TopScorersScreen> {
  late Future<GetTopscorersModel> _topScorersFuture;

  @override
  void initState() {
    super.initState();
    _topScorersFuture = GetTopscorersRepo().getTopScorers(widget.leagueId);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    return Scaffold(
      backgroundColor: Color(0xff222421),
      appBar: AppBar(
        backgroundColor: Color(0xff1B1B1B),
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                " Top",
                style: GoogleFonts.montserrat(
                    fontStyle: FontStyle.italic,
                    color: Color(0xffFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.05), // Responsive font size
              ),
              Text("Scorers",
                  style: GoogleFonts.montserrat(
                    fontStyle: FontStyle.italic,
                    color: Color(0xff6ABE66),
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.05)), // Responsive font size
            ],
          ),
      ),
      body: FutureBuilder<GetTopscorersModel>(
        future: _topScorersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.result.isEmpty) {
            return Center(child: Text('No top scorers found.'));
          } else {
            final topScorers = snapshot.data!.result;
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
                    '${scorer.teamName} - ${scorer.goals} goals',style: GoogleFonts.montserrat(color: Color(0xff6ABE66)),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
