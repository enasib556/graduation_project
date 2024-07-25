import 'package:flutter/material.dart';

class SportWidget extends StatelessWidget {
  final String imagePath;
  final String name;

  SportWidget({required this.imagePath, required this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.green[100], // لون خلفية الـ Card
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 100,
            width: 100,
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
