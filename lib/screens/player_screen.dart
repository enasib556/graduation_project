import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project_iti/data/cubits/players_cubit/players_cubit.dart';
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
         leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFE5E5E5)),
            onPressed: () {
              Navigator.of(context).pop();
            },),
        title: Row(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text('Players',
            style: GoogleFonts.montserrat(
              color: Colors.white,fontSize: 30,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic
            ),
            ),
            Text('team',
              style: GoogleFonts.montserrat(
                  color: Color(0xffCAF4B4),fontSize: 30,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic
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