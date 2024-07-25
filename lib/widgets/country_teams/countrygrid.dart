import 'package:flutter/material.dart';
import 'package:graduation_project_iti/widgets/country_teams/countrygridItem.dart';

class CountryGrid extends StatelessWidget {
  final List<dynamic> countries;
  final ScrollController scrollController;

  CountryGrid({required this.countries, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    if (countries.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      controller: scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns in the grid
        childAspectRatio: 0.9, // Aspect ratio for each grid item
        crossAxisSpacing: screenWidth * 0.05,
        mainAxisSpacing: screenHeight * 0.05,
      ),
      itemCount: countries.length,
      itemBuilder: (context, index) {
        final country = countries[index];
        return CountryGridItem(country: country);
      },
    );
  }
}
