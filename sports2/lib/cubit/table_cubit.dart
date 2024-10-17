

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Models/ListPlayerModel.dart';
import '../repos/get_repo.dart';
import '../screens/Listed_player_scereen.dart';



part 'table_state.dart';

class TableCubit extends Cubit<TableState> {
  TableCubit() : super(TableInitial());

  // Team ?foundUsers;

  Future<void> runFilter(String enteredKeyword,int x) async {

    emit(GetNewsLoading());
    List<PlayerData>? response = await GetNewsRepo().getNews(x);
    if (response == null) {
      emit(GetNewsError());    }
    //
    else {

      List<PlayerData> results;
      if (enteredKeyword.isEmpty) {
        // if the search field is empty? or only contains white-space, we'll display all users
        results = response ;
      } else {
        results = response.where((Player) =>
            Player.playerName.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
        // we use the toLowerCase() method to make it case-insensitive
      }
      //****

      List<PlayerData> filteredTeam = results;
      emit(ShowFilter(
          filteredTeam
      ));
      print('the tupe is    ${filteredTeam[0].playerType}');
    }



  }
  Future<void> getNews(int x) async {
    emit(GetNewsLoading());

    List<PlayerData>? response = await GetNewsRepo().getNews(x);

    if (response != null) {
      emit(GetNewsSuccess(response));
    } else {
      emit(GetNewsError());
    }
  }

}

