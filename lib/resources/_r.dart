
import 'package:agichat/resources/color.dart';
import 'package:agichat/resources/dimens.dart';
import 'package:agichat/resources/drawable.dart';
import 'package:agichat/resources/fonts.dart';
import 'package:agichat/resources/strings.dart';

class R {
  static void refreshClass() {
    _drawable = null;
    _color = null;
    _fonts = null;
    _string = null;
    _dimens = null;
  }

  static Drawable? _drawable;
  static Drawable get drawable => _drawable ??= Drawable();

  static AppColor? _color;
  static AppColor get color => _color ??= AppColor();

  static Fonts? _fonts;
  static Fonts get fonts => _fonts ??= Fonts();

  static AppStrings? _string;
  static AppStrings get string => _string ??= AppStrings();

  static Dimens? _dimens;
  static Dimens get dimens => _dimens ??= Dimens();
}
