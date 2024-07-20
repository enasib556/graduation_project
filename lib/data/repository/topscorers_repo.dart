import 'package:dio/dio.dart';
import 'package:graduation_project_iti/data/models/topscorers_model.dart';

class GetTopscorersRepo {
  final Dio _dio = Dio();

  Future<GetTopscorersModel> getTopScorers(int leagueId) async {
    final response = await _dio.get(
      'https://apiv2.allsportsapi.com/football/?&met=Topscorers&leagueId=$leagueId&APIkey=f06896886f1b1c3e4f649c2a759041a0016c2e1fc6de384e8213c84b4c4f8de8',
    );

    if (response.statusCode == 200) {
      final json = response.data;
      return GetTopscorersModel.fromJson(json);
    } else {
      throw Exception('Failed to load top scorers');
    }
  }
}

