import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project_iti/data/cubits/teams_cubit/teams_cubit.dart';
import 'package:graduation_project_iti/data/cubits/teams_cubit/teams_state.dart';
import 'package:graduation_project_iti/screens/topscorers_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

  bool _isValidUrl(String? url) {
    return Uri.tryParse(url ?? '')?.hasAbsolutePath ?? false;
  }

  @override
  Widget build(BuildContext context) {
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
              children: [
                Text(
                  " TE",
                  style: GoogleFonts.montserrat(
                      fontStyle: FontStyle.italic,
                      color: Color(0xffFFFFFF),
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.085),
                ),
                Text("AMS",
                    style: GoogleFonts.montserrat(
                      fontStyle: FontStyle.italic,
                      color: Color(0xff6ABE66),
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.085)),
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
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: TextField(
            cursorColor: Colors.white,
            controller: _searchController,
            decoration: InputDecoration(
              fillColor: Colors.white,
              hintText: 'Search for a team',
              hintStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              prefixIcon: Icon(Icons.search, color: Colors.white, size: screenWidth * 0.05),
            ),
          ),
        ),
        Expanded(
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
                    crossAxisSpacing: screenWidth * 0.02,
                    mainAxisSpacing: screenWidth * 0.02,
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
                        backgroundColor: Colors.transparent,
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
                );
              } else if (state is TeamsError) {
                return Center(child: Text(state.message, style: TextStyle(color: Colors.red)));
              } else {
                return Container();
              }
            },
          ),
        ),
      ],
    );
  }
}
