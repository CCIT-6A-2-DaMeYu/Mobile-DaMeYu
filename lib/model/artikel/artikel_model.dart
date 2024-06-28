// To parse this JSON data, do
//
//     final artikelModel = artikelModelFromJson(jsonString);

import 'dart:convert';

List<ArtikelModel> artikelModelFromJson(String str) => List<ArtikelModel>.from(json.decode(str).map((x) => ArtikelModel.fromJson(x)));

String artikelModelToJson(List<ArtikelModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ArtikelModel {
    String title;
    String image;
    String description;
    String id;

    ArtikelModel({
        required this.title,
        required this.image,
        required this.description,
        required this.id,
    });

    factory ArtikelModel.fromJson(Map<String, dynamic> json) => ArtikelModel(
        title: json["title"],
        image: json["image"],
        description: json["description"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "description": description,
        "id": id,
    };
}
