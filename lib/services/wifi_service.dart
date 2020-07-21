

import 'package:connectivity/connectivity.dart';

Stream<String> getStremWIFIBSD() async* {
  while (true) {
    String result = await Connectivity().getWifiBSSID();
    yield result;
  }
}
