import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_iti/data/cubits/players_cubit/players_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_iti/widgets/player_screen/search_bar.dart';
import 'package:graduation_project_iti/widgets/player_screen/table_view.dart';



class ListedPlayers extends StatelessWidget {
  ListedPlayers({super.key,required this.x});
  // PlayerModel player;
final int x;
  @override
  Widget build(BuildContext context) {

    context.read<TableCubit>().getNews(x);
    return Scaffold(
      backgroundColor: Color(0xff212320),

      appBar: AppBar(
        backgroundColor: Color(0xff1A1A1A),

        title: Row(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text('Players',
            style: TextStyle(
              color: Colors.white,fontSize: 30,
              fontWeight: FontWeight.w600
            ),
            ),
            Text('team',
              style: TextStyle(
                  color: Color(0xffCAF4B4),fontSize: 30,
                  fontWeight: FontWeight.w300
              ),
            )
          ],
        ),
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            SearcBar(teamid:x),
            TableView(),

          ],
        ),
      ) ,
    );
  }
}