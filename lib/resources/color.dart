import 'package:flutter/material.dart';

const _appColor = Color(0xFF384AD2);

class AppColor {
  final Color transparent = const Color(0x00000000);
  final Color white = const Color(0xFFFFFFFF);
  final Color black = const Color(0xFF000000);
  //final Color primary = const Color(0xFF384AD2);
  final Color primary = const Color(0xFF8F8FA7);
  final Color primaryLight = const Color(0xFFF3F5FF);
  final Color smoke = const Color(0xFF8F8FA7);
  final Color brandSmoke = const Color(0xFF8F8FA6);
  final Color secondary = const Color(0xFF575177);
  final Color secondaryDark = const Color(0xFF26223C);
  final Color river = const Color(0xFF4CAF50);
  final Color riverHover = const Color(0xFF95DB3D);
  final Color riverLight = const Color(0xFF80C02F).withOpacity(0.1);
  final Color candy = const Color(0xFFEA3959);
  final Color candyHover = const Color(0xFFC90054);
  final Color candyLight = const Color(0xFFDB4437).withOpacity(0.1);
  final Color orange = const Color(0xFFFC6B02);
  final Color orangeHover = const Color(0xFFFC9802);
  final Color orangeLight = const Color(0xFFFC6B02).withOpacity(0.1);
  final Color brown = const Color(0xFF863E16);
  final Color gold = const Color(0xFFFFD700);
  final Color goldHover = const Color(0xFFF3CD00);
  final Color info = const Color(0xFF0DCAF0);
  final Color infoHover = const Color(0xFF11A2D0);
  final Color infoLight = const Color(0xFF0DCAF0).withOpacity(0.1);
  final Color gray = const Color(0xFFB0B0B0);
  final Color grayLight = const Color(0xFFF1F1F1);
  final Color border = const Color(0xFFE2E2E2);
  final Color midnight = const Color(0xFF2F3845);
  final Color grayBg = const Color(0xFFF9F9F9);
  final Color yellowLight = const Color(0x00FFF536);
  final Color greenBg = const Color(0xFF52AB60);
  final Color brandColor = const Color(0xFFE804AF);
  final Color brandColorBg = const Color.fromARGB(255, 251, 234, 247);

  final Color appTextColor = const Color(0xFF886B86);
  final Color appTextColor2 = const Color(0xFFD9AD81);
  final Color appBackgroundColor = const Color(0xFFFFE9D3);
  final Color appBackgroundColor2 = const Color(0xFFFBE9D7);



  final MaterialColor primarySwatch = MaterialColor(_appColor.value, const {
    50: _appColor,
    100: _appColor,
    200: _appColor,
    300: _appColor,
    400: _appColor,
    500: _appColor,
    600: _appColor,
    700: _appColor,
    800: _appColor,
    900: _appColor,
  });
}