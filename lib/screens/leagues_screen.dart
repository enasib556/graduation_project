import 'package:flutter/material.dart';
import 'package:graduation_project_iti/data/models/get_leagues_model.dart';
import 'package:graduation_project_iti/data/repository/get_leagues_repo.dart';
import 'package:graduation_project_iti/screens/teams_screen.dart';

class LeaguesScreen extends StatefulWidget {
  final int countryKey;

  LeaguesScreen({required this.countryKey});

  @override
  State<LeaguesScreen> createState() => _LeaguesScreenState();
}

class _LeaguesScreenState extends State<LeaguesScreen> {
  late Future<LeagueData> futureLeaguesData;

  @override
  void initState() {
    super.initState();
    futureLeaguesData = LeaguesRepo().fetchLeaguesData(widget.countryKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF001432),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFE5E5E5)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xFF001432),
        centerTitle: true,
        title: Text(
          'Leagues',
          style: TextStyle(color: Color(0xFFE5E5E5), fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<LeagueData>(
        future: futureLeaguesData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load leagues data'));
          } else if (!snapshot.hasData || snapshot.data!.result.isEmpty) {
            return Center(child: Text('No leagues available'));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4.2 / 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              padding: EdgeInsets.all(5),
              itemCount: snapshot.data!.result.length,
              itemBuilder: (context, index) {
                var league = snapshot.data!.result[index];
                return GestureDetector(
                  onTap: () {
                    // ignore: unnecessary_null_comparison
                    if (league.leagueKey != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeamsScreen(leagueId: league.leagueKey!),
                        ),
                      );
                    } else {
                      // Handle the case where leagueId is null
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid league ID')),
                      );
                    }
                  },
                  child: Card(
                    color: Color.fromARGB(255, 5, 57, 134),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (league.leagueLogo != null && league.leagueLogo!.isNotEmpty)
                          Image.network(
                            league.leagueLogo!,
                            height: 50,
                            width: 50,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.error, color: Color(0xFFE5E5E5));
                            },
                          )
                        else
                          Icon(Icons.sports_soccer, color: Color(0xFFE5E5E5), size: 50),
                        SizedBox(height: 10),
                        Text(
                          league.leagueName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFE5E5E5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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
