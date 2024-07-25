import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project_iti/widgets/country_teams/location_provider.dart';

class CountryLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final double screenHeight = MediaQuery.of(context).size.height;

    if (locationProvider.currentPosition == null) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        'Current Location: ${locationProvider.currentPosition!.latitude}, ${locationProvider.currentPosition!.longitude}\nCountry: ${locationProvider.currentCountryName ?? "Unknown"}',
        style: GoogleFonts.montserrat(
            fontSize: screenHeight * 0.02, color: Colors.white),
      ),
    );
  }
}
