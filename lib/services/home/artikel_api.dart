import 'package:dameyu_project/model/artikel/artikel_model.dart';
import 'package:dio/dio.dart';

// Import your ArtikelModel and its JSON conversion functions here

class ArtikelAPI {
  final Dio _dio = Dio();

  Future<List<ArtikelModel>> getArtikel() async {
    try {
      final response = await _dio.get(
        "https://6669a1f32e964a6dfed5f371.mockapi.io/dameyu/artikel",
      );

      if (response.statusCode == 200) {
        // Jika respon sukses, konversi data menjadi List<ArtikelModel>
        List<dynamic> responseData = response.data as List<dynamic>;
        List<ArtikelModel> artikelList = responseData.map((json) => ArtikelModel.fromJson(json)).toList();
        
        return artikelList;
      } else {
        // Jika gagal, tampilkan pesan kesalahan
        print("Failed to fetch artikel. Status code: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      // Tangani error yang terjadi saat fetch data
      print("Error fetching artikel: $error");
      return [];
    }
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
