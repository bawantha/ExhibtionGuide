
import 'dart:convert';

ExhibitionModel exhibitionModelFromJson(String str) => ExhibitionModel.fromJson(json.decode(str));

String exhibitionModelToJson(ExhibitionModel data) => json.encode(data.toJson());

class ExhibitionModel {
  ExhibitionModel({
    this.id,
    this.name,
    this.uid,
  });

  final String id;
  final String name;
  final String uid;

  factory ExhibitionModel.fromJson(Map<String, dynamic> json) => ExhibitionModel(
    id: json["id"],
    name: json["name"],
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "uid": uid,
  };
}
