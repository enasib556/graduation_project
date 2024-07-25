import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingPage extends StatelessWidget {
  final Color color;
  final String imagePath;
  final String titlePart1;
  final String titlePart2;
  final Color titlePart1Color;
  final Color titlePart2Color;
  final String description;

  const OnboardingPage({
    required this.color,
    required this.imagePath,
    required this.titlePart1,
    required this.titlePart2,
    required this.titlePart1Color,
    required this.titlePart2Color,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 350,
              width: 450,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 40),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: titlePart1 + ' ',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: titlePart1Color,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  TextSpan(
                    text: titlePart2,
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: titlePart2Color,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              description,
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xffFFFFFF),
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}