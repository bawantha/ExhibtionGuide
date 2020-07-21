import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class VistorProvider {
  String currentMac = "";

  void changeCurrentMac(String mac) {
    currentMac = mac;
  }

  Future<bool> isPresmissionGranted() async {
    return Permission.locationAlways.isGranted;
  }

  Future<String> getCurrentMacAddress() async {
    return Connectivity().getWifiBSSID();
  }
}
