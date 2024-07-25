import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_iti/data/cubits/leagues_cubit/league_cubit.dart';
import 'package:graduation_project_iti/data/cubits/onboarding_cubit/OnboardingCubit.dart';
import 'package:graduation_project_iti/data/cubits/players_cubit/players_cubit.dart';
import 'package:graduation_project_iti/screens/country_screen.dart';
import 'package:graduation_project_iti/screens/home_screen.dart';
import 'package:graduation_project_iti/screens/leagues_screen.dart';
import 'package:graduation_project_iti/screens/login_screen.dart';
import 'package:graduation_project_iti/screens/onboarding_screen.dart';
import 'package:graduation_project_iti/screens/splash_screen.dart';
//import 'package:graduation_project_iti/screens/country_screen.dart';
import 'package:graduation_project_iti/screens/teams_screen_content.dart';
//import 'package:graduation_project_iti/screens/teams_screen.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project_iti/widgets/country_teams/location_provider.dart';
// /import 'screens/country_screen.dart'

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OnboardingCubit()),
        BlocProvider(create: (context) => TableCubit()), // إضافة OnboardingCubit
      ],
      child: MaterialApp(
        title: 'Sports App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(), 
         '/onboarding': (context) => OnboardingScreen(),
          '/login': (context) => LoginScreen(),
         '/home': (context) => HomeScreen(),
         '/football': (context) => CountryScreen(),
          // '/league': (context) => LeagueDetailsScreen(leagueId: '1'), 
          // استبدل '1' بمعرف الدوري الصحيح
          // يمكنك تخصيص القيم الأخرى هنا إذا لزم الأمر
        },
        debugShowCheckedModeBanner: false,
      ),
    );
    
  }
}

