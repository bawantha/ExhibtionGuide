import 'package:flutter/cupertino.dart';

class ExhibitionHomeProvider extends ChangeNotifier {
  bool _isMAcSetHall1 = false;
  bool _isMacSetHall2 = false;

  String _hall1Mac = "";
  String _hall2Mac = "";

  String get hall1Mac => _hall1Mac;

  void setHall1Mac(String mac) {
    _hall1Mac = mac;
    notifyListeners();
  }

  void setHall2Mac(String mac) {
    _hall2Mac = mac;
    notifyListeners();
  }

  bool get isMAcSetHall1 => _isMAcSetHall1;

  void macSetHall1() {
    _isMAcSetHall1 = true;
    notifyListeners();
  }

  void macDeSetHall1() {
    _isMAcSetHall1 = false;
    notifyListeners();
  }

  void macSetHall2() {
    _isMacSetHall2 = true;
    notifyListeners();
  }

  void macDeSetHall2() {
    _isMacSetHall2 = false;
    notifyListeners();
  }

  bool get isMacSetHall2 => _isMacSetHall2;

  String get hall2Mac => _hall2Mac;
}
