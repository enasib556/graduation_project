import 'package:dio/dio.dart';

class GetCountryRepo {
  Dio dio = Dio();

  Future<dynamic> getCountry() async {
    try {
      var response = await dio.get(
          "https://apiv2.allsportsapi.com/football/?met=Countries&APIkey=f06896886f1b1c3e4f649c2a759041a0016c2e1fc6de384e8213c84b4c4f8de8");
      return response.data; // Return response data
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching countries: $e');
      // ignore: use_rethrow_when_possible
      throw e; // Throw error for handling elsewhere
    }
  }
}
