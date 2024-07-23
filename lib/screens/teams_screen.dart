import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project_iti/data/repository/teams_repo.dart';
import 'package:graduation_project_iti/data/models/teams_model.dart';
import 'package:graduation_project_iti/screens/topscorers_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TeamsScreen extends StatefulWidget {
  final int leagueId;

  const TeamsScreen({required this.leagueId});

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
    // Get screen size
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xff222421),
        appBar: AppBar(
          leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFE5E5E5)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
          backgroundColor: Color(0xff1B1B1B),
          centerTitle: true,
          title: Padding(
           padding: const EdgeInsets.only(left: 50),
            child: Row(
             // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  " TE",
                  style: GoogleFonts.montserrat(
                      fontStyle: FontStyle.italic,
                      color: Color(0xffFFFFFF),
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.085), // Responsive font size
                ),
                Text("AMS",
                    style: GoogleFonts.montserrat(
                      fontStyle: FontStyle.italic,
                      color: Color(0xff6ABE66),
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.085)), // Responsive font size
              ],
            ),
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Color(0xff6ABE66),
            controller: _tabController,
            tabs: const [
              Tab(text: 'Teams'),
              Tab(text: 'Top Scorers'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildTeamsScreen(screenWidth),
            TopScorersScreen(leagueId: widget.leagueId),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamsScreen(double screenWidth) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.02), // Responsive padding
          child: TextField(cursorColor:  Colors.white,
            controller: _searchController,
            decoration: InputDecoration(
              fillColor: Colors.white,
              hintText: 'Search for a team',
              hintStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              prefixIcon: Icon(Icons.search, color: Colors.white, size: screenWidth * 0.05), // Responsive icon size
            ),
          ),
        ),
        Expanded(
          child: filteredTeams.isEmpty
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: screenWidth * 0.02, // Responsive spacing
                    mainAxisSpacing: screenWidth * 0.02, // Responsive spacing
                  ),
                  itemCount: filteredTeams.length,
                  itemBuilder: (context, index) {
                    final team = filteredTeams[index];
                    final teamName = team.teamName ?? 'Unknown';
                    final logoUrl = team.teamLogo ?? '';

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        
                        radius: screenWidth * 0.06,
                        backgroundColor: Colors.transparent, // Responsive radius
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _isValidUrl(logoUrl)
                                ? CachedNetworkImage(
                                    imageUrl: logoUrl,
                                    height: 100,
                                    width: 100,
                                    placeholder: (context, url) => const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => const Icon(Icons.error, color: Color(0xff6ABE66), size: 30),
                                  )
                                : const Icon(Icons.error, color: Color(0xff6ABE66), size: 30),
                            const SizedBox(height: 10),
                            Text(
                              teamName,
                              style: GoogleFonts.montserrat(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.045,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
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
