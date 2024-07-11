import 'package:dio/dio.dart';

class ApiService {
  final String baseUrl = 'http://34.128.114.101:8081/chatbot';
  final Dio dio;

  ApiService(this.dio);

  Future<Response> getChat() async {
    try {
      final response = await dio.get(baseUrl);
      return response;
    } catch (e) {
      rethrow;
    }
  }

   Future<Response> postChat(String message) async {
    try {
      print('Sending message: $message');
      final response = await dio.post(
        baseUrl,
        data: {'query': message}, // Mengirimkan data sebagai JSON
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
      return response;
    } catch (e) {
      if (e is DioException) {
        print('DioException occurred: ${e.response?.data}');
        if (e.response?.data is String && e.response?.data.contains('<html>')) {
          print('Received HTML response. Possible server error or wrong endpoint.');
        }
      } else {
        print('Error occurred: $e');
      }
      rethrow;
    }
  }
}