
// File: lib/model/result_predict/result_predict_model.dart
import 'dart:convert';

ResultPredictModel resultPredictModelFromJson(String str) => ResultPredictModel.fromJson(json.decode(str));

String resultPredictModelToJson(ResultPredictModel data) => json.encode(data.toJson());

class ResultPredictModel {
  Data data;
  Status status;

  ResultPredictModel({
    required this.data,
    required this.status,
  });

  factory ResultPredictModel.fromJson(Map<String, dynamic> json) => ResultPredictModel(
        data: Data.fromJson(json["data"]),
        status: Status.fromJson(json["status"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status.toJson(),
      };
}

class Data {
  int estimation;
  String ripeness;

  Data({
    required this.estimation,
    required this.ripeness,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        estimation: (json["Estimation"] is int) ? json["Estimation"] : (json["Estimation"] as double).toInt(),
        ripeness: json["Ripeness"],
      );

  Map<String, dynamic> toJson() => {
        "Estimation": estimation,
        "Ripeness": ripeness,
      };
}

class Status {
  int code;
  String message;

  Status({
    required this.code,
    required this.message,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}

// // To parse this JSON data, do
// //
// //     final resultPredictModel = resultPredictModelFromJson(jsonString);

// import 'dart:convert';

// ResultPredictModel resultPredictModelFromJson(String str) => ResultPredictModel.fromJson(json.decode(str));

// String resultPredictModelToJson(ResultPredictModel data) => json.encode(data.toJson());

// class ResultPredictModel {
//     Data data;
//     Status status;

//     ResultPredictModel({
//         required this.data,
//         required this.status,
//     });

//     factory ResultPredictModel.fromJson(Map<String, dynamic> json) => ResultPredictModel(
//         data: Data.fromJson(json["data"]),
//         status: Status.fromJson(json["status"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "data": data.toJson(),
//         "status": status.toJson(),
//     };
// }

// class Data {
//     int estimasi;
//     String kematangan;

//     Data({
//         required this.estimasi,
//         required this.kematangan,
//     });

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         estimasi: json["Estimasi"],
//         kematangan: json["Kematangan"],
//     );

//     Map<String, dynamic> toJson() => {
//         "Estimasi": estimasi,
//         "Kematangan": kematangan,
//     };
// }

// class Status {
//     int code;
//     String message;

//     Status({
//         required this.code,
//         required this.message,
//     });

//     factory Status.fromJson(Map<String, dynamic> json) => Status(
//         code: json["code"],
//         message: json["message"],
//     );

//     Map<String, dynamic> toJson() => {
//         "code": code,
//         "message": message,
//     };
// }
