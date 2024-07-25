import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project_iti/widgets/country_teams/location_provider.dart';

class CountryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(String) scrollToCountry;

  CountryAppBar({required this.scrollToCountry});

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final double screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFFE5E5E5)),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      scrolledUnderElevation: 0,
      backgroundColor: Color(0xff1B1B1B),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            " Coun",
            style: GoogleFonts.montserrat(
                fontStyle: FontStyle.italic,
                color: Color(0xffFFFFFF),
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.08),
          ),
          Text("tires",
              style: GoogleFonts.montserrat(
                  fontStyle: FontStyle.italic,
                  color: Color(0xff6ABE66),
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.08))
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.location_on,
            color: Color(0xffFFFFFF),
          ),
          onPressed: () async {
            await locationProvider.getCurrentLocation();
            if (locationProvider.currentCountryName != null) {
              scrollToCountry(locationProvider.currentCountryName!);
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
