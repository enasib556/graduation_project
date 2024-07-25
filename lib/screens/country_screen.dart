import 'package:flutter/material.dart';
import 'package:graduation_project_iti/widgets/country_teams/countryappbar.dart';
import 'package:graduation_project_iti/widgets/country_teams/countrygrid.dart';
import 'package:graduation_project_iti/widgets/country_teams/countrylocation.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project_iti/screens/leagues_screen.dart';
import 'package:graduation_project_iti/widgets/country_teams/location_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xff222421),
      appBar: CountryAppBar(
        scrollToCountry: scrollToCountry,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CountryLocation(),
          Expanded(
            child: CountryGrid(
              countries: countries,
              scrollController: _scrollController,
            ),
          ),
        ],
      ),
    );
  }
}
