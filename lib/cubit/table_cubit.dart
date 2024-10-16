import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Models/ListPlayerModel.dart';
import '../repos/get_repo.dart';
import '../screens/Listed_player_scereen.dart';



part 'table_state.dart';

class TableCubit extends Cubit<TableState> {
  TableCubit() : super(TableInitial());

Team ?foundUsers;

  Future<void> runFilter(String enteredKeyword,int x) async {

    emit(GetNewsLoading());
    Team ?response = await GetNewsRepo().getNews(x);
    if (response == null) {
      emit(GetNewsError());    }
    //
    else {

      List<Player> results;
      if (enteredKeyword.isEmpty) {
        // if the search field is empty? or only contains white-space, we'll display all users
        results = response.players;
      } else {
        results = response.players.where((Player) =>
            Player.playerName.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
        // we use the toLowerCase() method to make it case-insensitive
      }
      //****

      Team filteredTeam = Team(players: results);
      emit(ShowFilter(
          filteredTeam
      ));
    }



  }
  Future<void> getNews(int x) async {
    emit(GetNewsLoading());

    Team? response = await GetNewsRepo().getNews(x);

    if (response != null) {
      emit(GetNewsSuccess(response));
    } else {
      emit(GetNewsError());
    }
  }

}
