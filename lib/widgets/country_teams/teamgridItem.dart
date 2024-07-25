import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project_iti/screens/player_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TeamGridItem extends StatelessWidget {
  final dynamic team;

  const TeamGridItem({required this.team});

  bool _isValidUrl(String? url) {
    return Uri.tryParse(url ?? '')?.hasAbsolutePath ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final teamName = team.teamName ?? 'Unknown';
    final logoUrl = team.teamLogo ?? '';

    return InkWell(
      onTap: () {
        if (team.teamKey != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListedPlayers(x: team.teamKey!),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid team ID')),
          );
        }
      },
      child: Padding(
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
      ),
    );
  }
}
