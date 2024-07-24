import 'package:flutter/material.dart';

class PlayerImage extends StatelessWidget {
  final String imageUrl;

  const PlayerImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
        imageUrl,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.person, size: 40, color: Colors.white);
        },
        loadingBuilder: (context, child, progress) {
          if (progress == null) {
            return child;
          } else {
            return const CircularProgressIndicator();
          }
          },
    );
  }
}