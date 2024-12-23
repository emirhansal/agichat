import 'package:flutter/widgets.dart';

class ViewUtils {
  static ViewUtils? _instance;
  static ViewUtils getInstance() => _instance ??= ViewUtils();

  bool isTablet = false;

  ViewUtils() {
    _isTablet();
  }

  bool _isTablet() {
    // ignore: deprecated_member_use
    final data = MediaQueryData.fromView(WidgetsBinding.instance.window);
    var shortestSide = data.size.shortestSide;
    isTablet = shortestSide > 600;
    return isTablet;
  }
}
