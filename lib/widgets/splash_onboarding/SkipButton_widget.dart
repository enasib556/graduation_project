import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SkipButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      left: 20,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          'Skip',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xff6BDF70),
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}