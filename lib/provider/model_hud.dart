import 'package:flutter/foundation.dart';

class ModelHud extends ChangeNotifier {
  bool isLoading = false;
  loadingChange(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
