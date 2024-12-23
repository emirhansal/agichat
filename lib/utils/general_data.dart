import 'package:agichat/enums/enum_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'utilities.dart';

class GeneralData {
  static GeneralData? _instance;
  static GeneralData getInstance() => _instance ??= GeneralData();

  final String _spDARKMODE = 'dark_mode';
  final String _spPINKMODE = 'pink_mode';
  final String _spLANGUAGE = 'language';
  final String _spDEVICEID = 'device_id';
  final String _spAUTHTOKEN = 'auth_token';
  final String _spFCMTOKEN = 'fcm_token';
  final String _spISCHANGEDFCMTOKEN = 'is_changed_fcm_token';
  final String _spISREGISTEREDDEVICE = 'is_registered_device';
  final String _spREMEMBERME = 'remember_me';
  final String _spUSERNAME = 'username';
  final String _spPASSWORD = 'password';
  final String _spTAXNUMBER = 'tax_number';

  late Box<dynamic> hive;
  String? notificationLink;

  DateTime serverTime = DateTime.now().toLocal();

  int pageSize = 100;

  ThemeApperance getDarkMode() => ThemeApperance.values[Utilities.getUserSp(_spDARKMODE, defaultValue: ThemeApperance.dark.index)];
  ThemeApperance getPinkMode() => ThemeApperance.values[Utilities.getUserSp(_spPINKMODE, defaultValue: ThemeApperance.pink.index)];
  void setDarkMode(ThemeApperance value) async => Utilities.setUserSp(_spDARKMODE, value.index);
  void setPinkModel(ThemeApperance value) async => Utilities.setUserSp(_spPINKMODE, value.index);

  AppLanguage getLanguage() => AppLanguage.fromId(Utilities.getUserSp(_spLANGUAGE, defaultValue: AppLanguage.locale.id));
  void setLanguage(AppLanguage value) async => Utilities.setUserSp(_spLANGUAGE, value.id);

  void setDeviceId(String value) => Utilities.setUserSp(_spDEVICEID, value);

  String? getFCMToken() => Utilities.getUserSp(_spFCMTOKEN, defaultValue: null);
  void setFCMToken(String value) => Utilities.setUserSp(_spFCMTOKEN, value);

  bool getDeviceIsRegistered() => Utilities.getUserSp(_spISREGISTEREDDEVICE, defaultValue: false);
  void setDeviceIsRegistered(bool value) => Utilities.setUserSp(_spISREGISTEREDDEVICE, value);
  
  bool getIsChangedFCMToken() => Utilities.getUserSp(_spISCHANGEDFCMTOKEN, defaultValue: true);
  void setIsChangedFCMToken(bool value) => Utilities.setUserSp(_spISCHANGEDFCMTOKEN, value);

  bool getRememberMe() => Utilities.getUserSp(_spREMEMBERME, defaultValue: false);
  void setRememberMe(bool value) => Utilities.setUserSp(_spREMEMBERME, value);

  String? getAuthToken() => Utilities.getUserSp(_spAUTHTOKEN, defaultValue: null);
  void setAuthToken(String? value) => Utilities.setUserSp(_spAUTHTOKEN, value);

  String? getUsername() => Utilities.getUserSp(_spUSERNAME, defaultValue: null);
  void setUsername(String? value) => Utilities.setUserSp(_spUSERNAME, value);

  String? getPassword() => Utilities.getUserSp(_spPASSWORD, defaultValue: null);
  void setPassword(String? value) => Utilities.setUserSp(_spPASSWORD, value);

  String? getTaxNumber() => Utilities.getUserSp(_spTAXNUMBER, defaultValue: null);
  void setTaxNumber(String? value) => Utilities.setUserSp(_spTAXNUMBER, value);
}