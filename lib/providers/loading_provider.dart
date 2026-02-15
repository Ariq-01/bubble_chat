import 'package:flutter/widgets.dart';

class LoadingProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isloading => _isLoading;

  void show() {
    _isLoading = true;
    notifyListeners();
  }

  void hide() {
    _isLoading = false;
    notifyListeners();
  }
}
