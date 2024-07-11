import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  // Replace with your base URL
  final String baseUrl = 'http://34.128.114.101:8081';

  Future<Response> getChatbotResponse(String query) async {
    try {
      final response = await _dio.get(
        '$baseUrl/chatbot',
        queryParameters: {'query': query},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postChatbotQuery(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        '$baseUrl/chatbot',
        queryParameters: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
