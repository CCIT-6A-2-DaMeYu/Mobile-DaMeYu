import 'package:dameyu_project/model/result_predict/result_predict_model.dart';
import 'package:dio/dio.dart';

class ResultPredictApi {
  Dio dio = Dio();
  String baseUrl = 'http://34.128.114.101:8081/';
  
  Future<ResultPredictModel> postResultPredict() async {
    try {
      final response = await dio.post('$baseUrl/api/predict');
      return ResultPredictModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
