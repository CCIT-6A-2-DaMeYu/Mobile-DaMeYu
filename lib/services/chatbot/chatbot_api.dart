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

  Future<String> postChat(String message) async {
    try {
      print('Sending message: $message');
      final response = await dio.post(
        baseUrl,
        data: {'query': message},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
      
      if (response.statusCode == 200) {
        final data = response.data;
        // Asumsikan bahwa respons API adalah Map
        if (data is Map<String, dynamic> && data.containsKey('answer')) {
          return data['answer'];
        } else {
          return 'Unexpected response format';
        }
      } else {
        return 'Error: ${response.statusMessage}';
      }
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