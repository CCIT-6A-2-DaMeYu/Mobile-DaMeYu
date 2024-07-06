import 'package:dio/dio.dart';

class ArtikelAPI {
  final Dio _dio = Dio();

 Future<List<Map<String, dynamic>>> getArtikel() async {
    try {
      final response = await _dio.get(
        "https://6669a1f32e964a6dfed5f371.mockapi.io/dameyu/artikel",
      );

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(
          response.data.map((dynamic artikel) => artikel as Map<String, dynamic>),
        );
      } else {
        // ignore: avoid_print
        print("Failed to fetch artikel. Status code: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      // ignore: avoid_print
      print("Error fetching artikel: $error");
      return [];
    }
  }

  // Future<void> deleteReminder(String id) async {
  //   try {
  //     final response = await _dio.delete(
  //       "https://6571fd40d61ba6fcc0142a0c.mockapi.io/agriculture/reminder/$id",
  //     );

  //     if (response.statusCode != 200) {
  //       // ignore: avoid_print
  //       print("Failed to delete reminder. Status code: ${response.statusCode}");
  //     }
  //   } catch (error) {
  //     // ignore: avoid_print
  //     print("Error deleting reminder: $error");
  //   }
  // }

  // Future<void> postReminderData(String textFieldData, String timePickerData) async {
  //   try {
  //     final response = await _dio.post(
  //       "https://6571fd40d61ba6fcc0142a0c.mockapi.io/agriculture/reminder",
  //       data: {
  //         "description": textFieldData,
  //         "time": timePickerData,
  //       },
  //     );

  //     print("Reminder data post response: $response");

  //     if (response.statusCode == 200) {
  //       print("Reminder data posted successfully");
  //     } else {
  //       print("Failed to post Reminder data. Status code: ${response.statusCode}");
  //     }
  //   } catch (error) {
  //     print("Error posting Reminder data: $error");
  //   }
  // }
}