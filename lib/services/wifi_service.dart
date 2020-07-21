

import 'package:connectivity/connectivity.dart';
import 'package:exhibition_guide/services/db_service.dart';

Stream<String> getStremWIFIBSD() async* {
  EGDbService _db = EGDbService();
  String currentMac = "";
  while (true) {
    String result = await Connectivity().getWifiBSSID();
    await Future.delayed(Duration(seconds: 3));
    if (currentMac == result) {
      print("current mac is eqaul");
      yield result;
    } else {
      print("updating database");
      await _db.visitorVisited(result);
      await _db.visitorLeaved(currentMac);
      print("update done");
      currentMac = result;
      print("do some thing");
      yield result;
    }
  }
}
