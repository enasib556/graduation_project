import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models/ListPlayerModel.dart';
import '../Models/ListPlayerModel.dart';
import '../cubit/table_cubit.dart';
import '../widget/search_bar.dart';
import '../widget/table_view.dart';



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
            SearcBar(x:x),
            TableView(),

          ],
        ),
      ) ,
    );
  }
}
