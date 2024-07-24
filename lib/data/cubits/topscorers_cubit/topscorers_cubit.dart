import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
//import 'package:equatable/equatable.dart';
import 'package:graduation_project_iti/data/models/topscorers_model.dart';
import 'package:graduation_project_iti/data/repository/topscorers_repo.dart';

part 'topscorers_state.dart';

class TopScorersCubit extends Cubit<TopScorersState> {
  final GetTopscorersRepo _topscorersRepo;
  final int leagueId;

  TopScorersCubit(this._topscorersRepo, this.leagueId) : super(TopScorersInitial());

  Future<void> fetchTopScorers() async {
    emit(TopScorersLoading());
    try {
      final topScorers = await _topscorersRepo.getTopScorers(leagueId);
      emit(TopScorersLoaded(topScorers));
    } catch (e) {
      emit(TopScorersError(e.toString()));
    }
  }
}
