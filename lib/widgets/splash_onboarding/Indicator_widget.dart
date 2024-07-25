import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final bool isActive;

  const Indicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: isActive ? Color(0xffFFFFFF) : Color(0xffFFFFFF).withOpacity(0.5),
      ),
    );
  }
}