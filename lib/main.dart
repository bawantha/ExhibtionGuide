import 'package:exhibition_guide/organizer/exhibition_home.dart';
import 'package:exhibition_guide/organizer/oraganizer_home.dart';
import 'package:exhibition_guide/organizer/organizer_login.dart';
import 'package:exhibition_guide/visitor/exhibition_identifier.dart';
import 'package:exhibition_guide/visitor/stall_description.dart';
import 'package:exhibition_guide/visitor/visitor_home.dart';
import 'package:exhibition_guide/visitor/visitor_login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExhibitionGuide());
}

class ExhibitionGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/visitorLogin': (context) => VisitorLogin(),
        '/exhibitionIdentifier': (context) => ExhibitionIdentifier(),
        '/visitorHome': (context) => VisitorHome(),
        '/stall': (context) => StallDescription(),
        '/organizerLogin': (context) => OrganizerLogin(),
        '/organizerHome': (context) => OrganizerHome(),
        '/exhibitionHome': (context) => ExhibitionHome()
      },
      debugShowCheckedModeBanner: false,
      home: OrganizerLogin(),
    );
  }
}
