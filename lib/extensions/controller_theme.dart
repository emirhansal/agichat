import 'package:agichat/enums/enum_app.dart';
import 'package:agichat/resources/_r.dart';
import 'package:agichat/utils/general_data.dart';

class ThemeController {
  static ThemeController? _instance;
  static ThemeController getInstance() => _instance ??= ThemeController();

  ThemeApperance currentAppTheme = ThemeApperance.light;

  void setTheme(ThemeApperance theme) {
    currentAppTheme = theme;
    if (theme == ThemeApperance.pink) {
      GeneralData.getInstance().setPinkModel(theme);
    }
    if (theme == ThemeApperance.dark) {
      GeneralData.getInstance().setDarkMode(theme);
    }
    R.refreshClass();
  }

  void getTheme() {
    setTheme(GeneralData.getInstance().getDarkMode());
  }
}
