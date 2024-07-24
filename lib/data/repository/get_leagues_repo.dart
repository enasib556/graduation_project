import 'package:dio/dio.dart';
import 'package:graduation_project_iti/data/models/get_leagues_model.dart';

class LeaguesRepo {
  final Dio dio = Dio();

  Future<LeagueData> fetchLeaguesData(int countryKey) async {
    try {
      final response = await dio.get(
        'https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=440ab5ebdb896a1744ef42de421b0d3da3daded6ea216ae84a73264530a7758c&countryId=$countryKey'
      );
      if (response.statusCode == 200) {
        return LeagueData.fromJson(response.data);
      } else {
        throw Exception('Failed to load leagues data');
      }
    } catch (e) {
      throw Exception('Failed to load leagues data: $e');
    }
  }
}
