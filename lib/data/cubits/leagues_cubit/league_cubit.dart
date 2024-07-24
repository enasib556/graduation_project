import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:graduation_project_iti/data/models/get_leagues_model.dart';
import 'package:graduation_project_iti/data/repository/get_leagues_repo.dart';

part 'league_state.dart';

class LeagueCubit extends Cubit<LeagueState> {
  final LeaguesRepo leaguesRepo;

  LeagueCubit(this.leaguesRepo) : super(LeagueInitial());

  void fetchLeagues(int countryKey) async {
    try {
      emit(LeagueLoading());
      final leagueData = await leaguesRepo.fetchLeaguesData(countryKey);
      emit(LeagueLoaded(leagueData));
    } catch (e) {
      emit(LeagueError("Failed to fetch leagues: $e"));
    }
  }
}
