import 'package:exhibition_guide/Providers/exhibtion_home_provider.dart';
import 'package:exhibition_guide/Providers/visitor_provider.dart';
import 'package:exhibition_guide/organizer/exhibition_home.dart';
import 'package:exhibition_guide/organizer/hall_details.dart';
import 'package:exhibition_guide/organizer/oraganizer_home.dart';
import 'package:exhibition_guide/organizer/organizer_login.dart';
import 'package:exhibition_guide/visitor/exhibition_identifier.dart';
import 'package:exhibition_guide/visitor/stall_description.dart';
import 'package:exhibition_guide/visitor/visitor_home.dart';
import 'package:exhibition_guide/visitor/visitor_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ExhibitionGuide());
}

class ExhibitionGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ExhibitionHomeProvider>(
            create: (_) => ExhibitionHomeProvider()),
        FutureProvider<bool>(
            create: (_) => VistorProvider().isPresmissionGranted()),
        FutureProvider<String>(
            create: (_) => VistorProvider().getCurrentMacAddress())
      ],
      child: MaterialApp(
        routes: {
          '/visitorLogin': (context) => VisitorLogin(),
          '/exhibitionIdentifier': (context) => ExhibitionIdentifier(),
          '/visitorHome': (context) => VisitorHome(),
          '/stall': (context) => StallDescription(),
          '/organizerLogin': (context) => OrganizerLogin(),
          '/organizerHome': (context) => OrganizerHome(),
          '/exhibitionHome': (context) => ExhibitionHome(),
          '/hallDetails': (context) => HallDetails(),
        },
        debugShowCheckedModeBanner: false,
        home: VisitorHome(),
      ),
    );
  }
}

///
/// ChangeNotifierProvider<ExhibitionHomeProvider>(
//      create: (BuildContext context) => ExhibitionHomeProvider(),
//      child: ,
//    );