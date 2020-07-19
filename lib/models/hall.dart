import 'dart:convert';

import 'package:flutter/cupertino.dart';

Hall hallFromJson(String str) => Hall.fromJson(json.decode(str));

String hallToJson(Hall data) => json.encode(data.toJson());

class Hall {
  Hall({
    this.mac,
    @required this.hallName,
    @required this.exhibitionId,
    this.crowd,
  });

   String mac;
  final String hallName;
  final double exhibitionId;
  int crowd=0;

  factory Hall.fromJson(Map<String, dynamic> json) => Hall(
    mac: json["mac"],
    hallName: json["hallName"],
    exhibitionId: json["exhibitionId"].toDouble(),
    crowd: json["crowd"],
  );

  Map<String, dynamic> toJson() => {
    "mac": mac,
    "hallName": hallName,
    "exhibitionId": exhibitionId,
    "crowd": crowd,
  };
}
