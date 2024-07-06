// To parse this JSON data, do
//
//     final resultPredictModel = resultPredictModelFromJson(jsonString);

import 'dart:convert';

ResultPredictModel resultPredictModelFromJson(String str) => ResultPredictModel.fromJson(json.decode(str));

String resultPredictModelToJson(ResultPredictModel data) => json.encode(data.toJson());

class ResultPredictModel {
    Data data;

    ResultPredictModel({
        required this.data,
    });

    factory ResultPredictModel.fromJson(Map<String, dynamic> json) => ResultPredictModel(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    int estimasi;
    String kematangan;

    Data({
        required this.estimasi,
        required this.kematangan,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        estimasi: json["Estimasi"],
        kematangan: json["Kematangan"],
    );

    Map<String, dynamic> toJson() => {
        "Estimasi": estimasi,
        "Kematangan": kematangan,
    };
}
