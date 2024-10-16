import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_news/screens/Listed_player_scereen.dart';
import 'package:sport_news/screens/ShowDialog.dart';

import 'package:sport_news/widget/ViewPlayer.dart';

import 'cubit/table_cubit.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
debugShowCheckedModeBanner: false,
        home:BlocProvider(create:(context)=>TableCubit(),
        child: ListedPlayers(x:44),)
        // home:BlocProvider(create:(context)=>TeamsCubit(),
        // child: CountryScreen(),)
//       home: SportsPage(),
        //BlocProvider(
      //       create: (context) =>FastFilterBarCubit(),
      //       child:FastFilterBarCubitt())
    );
  }
}

