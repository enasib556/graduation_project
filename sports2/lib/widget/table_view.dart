import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../Models/ListPlayerModel.dart';
import '../cubit/table_cubit.dart';
import 'ViewPlayer.dart';

class TableView extends StatelessWidget {
  const TableView({super.key});
  // final Player player;

  @override
  Widget build(BuildContext context) {
    TableCubit _cubit=context.read<TableCubit>();
    return SingleChildScrollView(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<TableCubit,TableState>(
          builder: (context,state) {
        if (state is GetNewsInitial) {
          return Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.3,),
              Text('please click the button to get news'
              ,style: TextStyle(
                  color: Colors.white,fontSize: 25
                ),
              ),
            ],
          );
        } else if (state is GetNewsLoading) {
          return Column(

            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.3,),

              SizedBox(
                height:50,
                width:50,
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                  strokeAlign: CircularProgressIndicator.strokeAlignInside,

                  color:  Color(0xff3E672B),
                ),
              ),
            ],
          );
        } else if (state is GetNewsSuccess){
         return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: state.responseModel.length,

                itemBuilder: (context,index) {
                  return
                    ViewPlayer(
                        img:   state.responseModel[index].playerImage
                        , name:  state.responseModel[index].playerName,
                      playerAge:state.responseModel[index].playerAge ,
                        playerAssists: state.responseModel[index].playerAssists,
                      playerGoals: state.responseModel[index].playerGoals,
                      playerNumber: state.responseModel[index].playerNumber,
                      playerRedCards: state.responseModel[index].playerRedCards,
                      playerYellowCards: state.responseModel[index].playerYellowCards,
                      //   playerCountery:state.responseModel.players[index].playerCountery,
                      playerCountery: state.responseModel[index].playerCountry,
                      type: state.responseModel[index].playerType,

                    );
                }
                )
      );
        }
        else if (state is ShowFilter){
          return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: state.result.length,
                  itemBuilder: (context,index) {
                    return ViewPlayer( type:  state.result[index].playerType
                        , img:   state.result[index].playerImage
                        , name:  state.result[index].playerName,
                        playerAge:state.result[index].playerAge ,
                        playerAssists: state.result[index].playerAssists,
                        playerGoals: state.result[index].playerGoals,
                        playerNumber: state.result[index].playerNumber,
                        playerRedCards: state.result[index].playerRedCards,
                        playerYellowCards: state.result[index].playerYellowCards,
                        // playerCountery:state.result.players[index].playerCountery
                      playerCountery: state.result[index].playerCountry,
                    );
                  }
              )
          );
        }
        else {
          return Center(
            child: Text('Something went wrong'),
          );
        }

          }
          )
        ],
      ),
    );
  }
}
