// To parse this JSON data, do
//
//     final message = messageFromMap(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

Message messageFromMap(String str) => Message.fromMap(json.decode(str));

String messageToMap(Message data) => json.encode(data.toMap());

class Message {
  Message({
    @required this.message,
    @required this.time,
  });

  final String message;
  final Timestamp time;

  factory Message.fromMap(Map<String, dynamic> json) => Message(
    message: json["message"],
    time: json["time"],
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "time": time,
  };
}
