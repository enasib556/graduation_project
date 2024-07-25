import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_iti/data/cubits/players_cubit/players_cubit.dart';
import 'package:graduation_project_iti/data/models/players_model.dart';
import 'package:graduation_project_iti/screens/player_screen.dart';


class SearcBar extends StatelessWidget {
  final teamid;
   SearcBar({super.key, required this.teamid});
   //ListedPlayers listedPlayers=ListedPlayers(teamid: Team(players: []),);


  @override
  Widget build(BuildContext context) {
    TableCubit _cubit=context.read<TableCubit>();
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top:5,right: 19,bottom: 13,left: 19),
            child: SizedBox(
              height: 55,

              child: TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.normal,
                  ),



                  onChanged: (value) => _cubit.runFilter(value,teamid),

                  decoration: InputDecoration(
                    fillColor: Color(0xFF364133),
                    filled: true,
                    prefixIcon: Icon(Icons.search,size: 35,),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 60
                    ),
                    prefixIconColor: Color(0xffA5ADA2),
                    labelText: 'search',
                    labelStyle: TextStyle(
                      fontFamily:'Nunito',
                      fontSize: 25,
                      color: Color(0xffA5ADA2),
                      // height: 16.37,
                    ),
                    focusedBorder: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Color(0xff3E672B), width: 3.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Color(0xff596456), width: 3.0),
                    ),

                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(30.0),
                    //   // borderSide: BorderSide(
                    //   //   color: Colors.cyan, // Set the border color
                    //   //   width: 50.0,// Set the border width
                    //   // ),
                    // ),

                  )
              ),
            ),
          ),
        )
      ],
    );
  }
}