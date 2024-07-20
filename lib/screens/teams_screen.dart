import 'package:flutter/material.dart';
import 'package:graduation_project_iti/data/repository/get_teams_repo.dart';
import 'package:graduation_project_iti/data/models/get_teams_model.dart';
import 'package:graduation_project_iti/screens/topscorers_screen.dart';

class TeamsScreen extends StatefulWidget {
  final int leagueId;

  TeamsScreen({required this.leagueId});

  @override
  _TeamsScreenState createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> with SingleTickerProviderStateMixin {
  List<Result> teams = [];
  List<Result> filteredTeams = [];
  final TextEditingController _searchController = TextEditingController();
  final GetTeamsRepo _getTeamsRepo = GetTeamsRepo();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchTeams();
    _searchController.addListener(_filterTeams);
  }

  void _filterTeams() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      setState(() {
        filteredTeams = teams
            .where((team) => team.teamName?.toLowerCase().contains(query.toLowerCase()) ?? false)
            .toList();
      });
    } else {
      setState(() {
        filteredTeams = teams;
      });
    }
  }

  void fetchTeams() async {
    try {
      final data = await _getTeamsRepo.getTeams(widget.leagueId);
      setState(() {
        teams = data.result;
        filteredTeams = teams;
      });
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching teams: $e')),
      );
    }
  }

  bool _isValidUrl(String? url) {
    return Uri.tryParse(url ?? '')?.hasAbsolutePath ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('League Details'),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Teams'),
              Tab(text: 'Top Scorers'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildTeamsScreen(), // Teams screen content
          TopScorersScreen(leagueId: widget.leagueId), // Top scorers screen
          ],
        ),
      ),
    );
  }

  Widget _buildTeamsScreen() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search for a team',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: filteredTeams.isEmpty
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: filteredTeams.length,
                  itemBuilder: (context, index) {
                    final team = filteredTeams[index];
                    final teamName = team.teamName ?? 'Unknown';
                    final logoUrl = team.teamLogo ?? '';

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: Colors.grey,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _isValidUrl(logoUrl)
                                ? Image.network(
                                    logoUrl,
                                    width: 50,
                                    height: 50,
                                    errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                                  )
                                : Icon(Icons.error),
                            SizedBox(height: 8),
                            Text(teamName),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

