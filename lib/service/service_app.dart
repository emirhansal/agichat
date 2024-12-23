import 'package:flutter/material.dart';

class ServiceApp extends ChangeNotifier {
  List<String> listenerViews = [];

  notify() => notifyListeners();
}
