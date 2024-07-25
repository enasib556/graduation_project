import 'package:flutter/material.dart';

class TeamsScreenSearchBar extends StatelessWidget {
  final TextEditingController searchController;

  const TeamsScreenSearchBar({required this.searchController});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.02),
      child: TextField(
        cursorColor: Colors.white,
        controller: searchController,
        decoration: InputDecoration(
          fillColor: Color(0xff333333), // Adjusted for dark theme
          hintText: 'Search for a team',
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          prefixIcon: Icon(Icons.search, color: Colors.white, size: screenWidth * 0.05),
        ),
      ),
    );
  }
}
