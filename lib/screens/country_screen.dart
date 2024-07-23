//  import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project_iti/screens/leagues_screen.dart';
import 'package:graduation_project_iti/widgets/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../data/repository/country_repo.dart';

class CountryScreen extends StatefulWidget {
  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  List<dynamic> countries = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  void fetchCountries() async {
    try {
      var response = await GetCountryRepo().getCountry();
      setState(() {
        if (response != null) {
          countries = response['result'];
        }
      });
    } catch (e) {
      // Handle errors here
    }
  }

  void scrollToCountry(String countryName) {
    final index = countries
        .indexWhere((country) => country['country_name'] == countryName);
    if (index != -1) {
      final double targetOffset = index * 50.0;
      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  bool _isValidUrl(String url) {
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }

  bool isCountryCurrentLocation(dynamic country) {
    return country['country_name'] ==
        Provider.of<LocationProvider>(context).currentCountryName;
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (locationProvider.currentPosition != null)
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Current Location: ${locationProvider.currentPosition!.latitude}, ${locationProvider.currentPosition!.longitude}\nCountry: ${locationProvider.currentCountryName ?? "Unknown"}',
                style: GoogleFonts.montserrat(
                    fontSize: screenHeight * 0.02, color: Colors.white),
              ),
            ),
          Expanded(
            child: countries.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Number of columns in the grid
                      childAspectRatio: 0.9, // Aspect ratio for each grid item
                      crossAxisSpacing: screenWidth * 0.05,
                      mainAxisSpacing: screenHeight * 0.05,
                    ),
                    itemCount: countries.length,
                    itemBuilder: (context, index) {
                      final country = countries[index];
                      final countryName = country['country_name'] ?? 'Unknown';
                      final logoUrl = country['country_logo'] ?? '';
                      final countryKey = country['country_key'];

                      return InkWell(
                        onTap: () {
                          if (countryKey != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LeaguesScreen(countryKey: countryKey),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Invalid country key')),
                            );
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: screenWidth * 0.12,
                              backgroundColor:
                                  locationProvider.currentPosition != null &&
                                          isCountryCurrentLocation(country)
                                      ? Color(0xff6ABE66)
                                      : Colors.transparent,
                              child: CircleAvatar(
                                backgroundColor: Color(0xff222421),
                                radius: screenWidth * 0.1,
                                backgroundImage: _isValidUrl(logoUrl)
                                    ? CachedNetworkImageProvider(logoUrl)
                                    : null,
                                child: !_isValidUrl(logoUrl)
                                    ? const Icon(Icons.error,
                                        color: Color(0xff6ABE66), size: 30)
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
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
