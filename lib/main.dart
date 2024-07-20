import 'package:flutter/material.dart';
import 'package:graduation_project_iti/screens/teams_screen.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project_iti/widgets/location_provider.dart';
//import 'screens/country_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: MyApp(),
    ),
  );
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:TeamsScreen(  leagueId: 1,),
    );
  }
}