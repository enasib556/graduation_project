import 'package:flutter/material.dart';
import 'package:graduation_project_iti/screens/leagues_screen.dart';
import 'package:graduation_project_iti/widgets/location_provider.dart';
import 'package:provider/provider.dart';
import '../data/repository/country_repo.dart';

// ignore: use_key_in_widget_constructors
class CountryScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  List<dynamic> countries = [];
  final ScrollController _scrollController = ScrollController();
  final int _crossAxisCount = 2; // Number of columns in the grid
  final double _itemHeight = 130.0; // Height of each grid item including spacing

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
    final index = countries.indexWhere((country) => country['country_name'] == countryName);
    if (index != -1) {
      final int row = (index / _crossAxisCount).floor();
      final double targetOffset = row * _itemHeight;
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
    return country['country_name'] == Provider.of<LocationProvider>(context).currentCountryName;
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
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
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Current Location: ${locationProvider.currentPosition!.latitude}, ${locationProvider.currentPosition!.longitude}\nCountry: ${locationProvider.currentCountryName ?? "Unknown"}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          Expanded(
            child: countries.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _crossAxisCount, // Number of columns in the grid
                      childAspectRatio: 3 / 2, // Aspect ratio for each grid item
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
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
                                builder: (context) => LeaguesScreen(countryKey: countryKey),
                              ),
                            );
                          } else {
                            // Handle the case where countryKey is null
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Invalid country key')),
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                color: locationProvider.currentPosition != null && isCountryCurrentLocation(country)
                                    ? Colors.green // Special color for current location
                                    : Colors.grey, // Default color
                                width: 2,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _isValidUrl(logoUrl)
                                    ? Image.network(
                                        logoUrl,
                                        width: 50,
                                        height: 50,
                                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                                      )
                                    : const Icon(Icons.error),
                                const SizedBox(height: 8),
                                Text(countryName),
                              ],
                            ),
                          ),
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
