import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project_iti/data/models/get_leagues_model.dart';
import 'package:graduation_project_iti/data/repository/get_leagues_repo.dart';
import 'package:graduation_project_iti/screens/teams_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LeaguesScreen extends StatefulWidget {
  final int countryKey;

  // ignore: use_key_in_widget_constructors
  const LeaguesScreen({required this.countryKey});

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
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
           // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                " Lea",
                style: GoogleFonts.montserrat(
                    fontStyle: FontStyle.italic,
                    color: Color(0xffFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.085),
              ),
              Text("gues",
                  style: GoogleFonts.montserrat(
                      fontStyle: FontStyle.italic,
                      color: Color(0xff6ABE66),
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.085))
            ],
          ),
        ),
      ),
      body: FutureBuilder<LeagueData>(
        future: futureLeaguesData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load leagues data'));
          } else if (!snapshot.hasData || snapshot.data!.result.isEmpty) {
            return const Center(child: Text('No leagues available'));
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: screenWidth * 0.03,
                  mainAxisSpacing: screenHeight * 0.03,
                ),
                padding: const EdgeInsets.all(15),
                itemCount: snapshot.data!.result.length,
                itemBuilder: (context, index) {
                  var league = snapshot.data!.result[index];
                  return InkWell(
                    onTap: () {
                      if (league.leagueKey != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TeamsScreen(leagueId: league.leagueKey!),
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
                            radius: screenWidth * 0.16,
                            backgroundColor: Color(0xff222421),
                            child: CachedNetworkImage(
                              imageUrl: league.leagueLogo ?? '',
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                backgroundImage: imageProvider,
                                radius: screenWidth * 0.14,
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(
                                  Icons.sports_soccer,
                                  color: Color(0xff6ABE66),
                                  size: 90),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(league.leagueName,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xffFFFFFF),
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.045),
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
        },
      ),
    );
  }
}
