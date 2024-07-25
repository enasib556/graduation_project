import 'package:dio/dio.dart';
import 'package:graduation_project_iti/data/models/players_model.dart';

class GetNewsRepo {
  Dio dio = Dio();

  Future<List<PlayerData>?> getNews( int a) async {
    Response response;

    try {
      response = await dio.get(
          'https://apiv2.allsportsapi.com/football/?met=Players&APIkey=94edd52d7afc6f99d8f11696ca15d1b77b672869981967125426cb58b006451a&teamId=$a');

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == 1) {
          List<PlayerData> modelResponse = (data['result'] as List)
              .map((playerJson) => PlayerData.fromJson(playerJson))
              .toList();
          return modelResponse;
        } else {
          // Handle the case where the API does not return success
          return null;
        }

      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}