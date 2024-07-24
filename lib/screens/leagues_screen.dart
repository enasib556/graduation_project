import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project_iti/data/cubits/leagues_cubit/league_cubit.dart';
import 'package:graduation_project_iti/data/repository/get_leagues_repo.dart';
import 'package:graduation_project_iti/screens/teams_screen.dart';
import 'package:cached_network_image/cached_network_image.dart'; 

class LeaguesScreen extends StatelessWidget {
  final int countryKey;

  const LeaguesScreen({Key? key, required this.countryKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LeagueCubit(LeaguesRepo())..fetchLeagues(countryKey),
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
                  " Lea",
                  style: GoogleFonts.montserrat(
                      fontStyle: FontStyle.italic,
                      color: Color(0xffFFFFFF),
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.085),
                ),
                Text("gues",
                    style: GoogleFonts.montserrat(
                        fontStyle: FontStyle.italic,
                        color: Color(0xff6ABE66),
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.085))
              ],
            ),
          ),
        ),
        body: BlocBuilder<LeagueCubit, LeagueState>(
          builder: (context, state) {
            if (state is LeagueLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LeagueError) {
              return Center(child: Text(state.message));
            } else if (state is LeagueLoaded) {
              if (state.leagueData.result.isEmpty) {
                return const Center(child: Text('No leagues available'));
              } else {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: MediaQuery.of(context).size.width * 0.03,
                      mainAxisSpacing: MediaQuery.of(context).size.height * 0.03,
                    ),
                    padding: const EdgeInsets.all(15),
                    itemCount: state.leagueData.result.length,
                    itemBuilder: (context, index) {
                      var league = state.leagueData.result[index];
                      return InkWell(
                        onTap: () {
                          if (league.leagueKey != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TeamsScreen(leagueId: league.leagueKey!),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Invalid league ID')),
                            );
                          }
                        },
                        child: Material(
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width * 0.16,
                                backgroundColor: Color(0xff222421),
                                child: CachedNetworkImage(
                                  imageUrl: league.leagueLogo ?? '',
                                  imageBuilder: (context, imageProvider) => CircleAvatar(
                                    backgroundImage: imageProvider,
                                    radius: MediaQuery.of(context).size.width * 0.14,
                                  ),
                                  placeholder: (context, url) => const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => const Icon(
                                      Icons.sports_soccer,
                                      color: Color(0xff6ABE66),
                                      size: 90),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                league.leagueName,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xffFFFFFF),
                                    fontWeight: FontWeight.bold,
                                    fontSize: MediaQuery.of(context).size.width * 0.045),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            } else {
              return const Center(child: Text('Press the button to fetch leagues'));
            }
          },
        ),
      ),
    );
  }
}
