import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Scorers'),
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
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${scorer.teamName} - ${scorer.goals} goals',
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
