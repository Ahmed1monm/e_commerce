import 'package:flutter/foundation.dart';

class AdminMode extends ChangeNotifier {
  bool isAdmin = false;
  changeAdminMode(bool val) {
    isAdmin = val;
    notifyListeners();
  }
}
