import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project_iti/screens/leagues_screen.dart';
import 'package:graduation_project_iti/widgets/country_teams/location_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CountryGridItem extends StatelessWidget {
  final dynamic country;

  CountryGridItem({required this.country});

  bool _isValidUrl(String url) {
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }

  bool isCountryCurrentLocation(BuildContext context, dynamic country) {
    return country['country_name'] ==
        Provider.of<LocationProvider>(context).currentCountryName;
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final double screenWidth = MediaQuery.of(context).size.width;

    final countryName = country['country_name'] ?? 'Unknown';
    final logoUrl = country['country_logo'] ?? '';
    final countryKey = country['country_key'];

    return InkWell(
      onTap: () {
        if (countryKey != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LeaguesScreen(countryKey: countryKey),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid country key')),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: screenWidth * 0.12,
            backgroundColor: locationProvider.currentPosition != null &&
                    isCountryCurrentLocation(context, country)
                ? Color(0xff6ABE66)
                : Colors.transparent,
            child: CircleAvatar(
              backgroundColor: Color(0xff222421),
              radius: screenWidth * 0.1,
              backgroundImage: _isValidUrl(logoUrl)
                  ? CachedNetworkImageProvider(logoUrl)
                  : null,
              child: !_isValidUrl(logoUrl)
                  ? const Icon(Icons.error, color: Color(0xff6ABE66), size: 30)
                  : null,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            countryName,
            style: GoogleFonts.montserrat(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.04,
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
