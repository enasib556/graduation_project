// TODO Implement this library.
import 'package:flutter/material.dart';

class SportWidget extends StatelessWidget {
  final String imagePath;
  final String name;

  SportWidget({
    required this.imagePath,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(imagePath),
          Text(name),
        ],
      ),
    );
  }
}
