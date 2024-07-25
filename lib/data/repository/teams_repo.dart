import 'package:dio/dio.dart';
import 'package:graduation_project_iti/data/models/teams_model.dart';

class GetTeamsRepo {
  final Dio dio = Dio();

  Future<GetTeamsModel> getTeams(int leagueId) async {
    const apiKey = 'f06896886f1b1c3e4f649c2a759041a0016c2e1fc6de384e8213c84b4c4f8de8';
    final url = 'https://apiv2.allsportsapi.com/football/?met=Teams&APIkey=$apiKey&leagueId=$leagueId';

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return GetTeamsModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load teams');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching teams: $e');
      // ignore: use_rethrow_when_possible
      throw e;
    }
  }
}