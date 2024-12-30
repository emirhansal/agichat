import 'dart:async';

import 'package:agichat/base/base_view.dart';
import 'package:agichat/enums/enum_app.dart';
import 'package:agichat/extensions/controller_language.dart';
import 'package:agichat/firebase_options.dart';
import 'package:agichat/main.reflectable.dart';
import 'package:agichat/provider_setup.dart';
import 'package:agichat/resources/_r.dart';
import 'package:agichat/service/router.dart';
import 'package:agichat/service/service_route.dart';
import 'package:agichat/utils/general_data.dart';
import 'package:agichat/utils/view_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      FlavorConfig(
        name: Flavor.prod.value,
        location: BannerLocation.topEnd,
        variables: {},
      );

      initializeReflectable();

      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);

      await Hive.initFlutter();
      GeneralData.getInstance().hive =
          await Hive.openBox('85383af9c4684bc5e4fd4633042423d658fc518c');

      await LanguageController.initialize();
      await LanguageController.setLanguage(AppLanguage.en);

      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp]);

      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: R.color.transparent,
          systemNavigationBarColor: R.color.transparent));

      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
          overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

      runApp(const MyApp());
    },
    (error, stack) =>
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
  );
}

class MyApp extends StatelessWidget with BaseView {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewUtils.getInstance();
    return MultiProvider(
      providers: providers,
      child: Builder(builder: (context) {
        router(context);
        return MaterialApp.router(
          routerConfig: ServiceRoute.rootRouter.config(navigatorObservers: () => [RooterObserver()]),
          theme: ThemeData(
            useMaterial3: false,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: R.color.primary,
              foregroundColor: R.color.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            scaffoldBackgroundColor: R.color.white,
            fontFamily: R.fonts.displayRegular,
            primarySwatch: R.color.primarySwatch,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            bottomSheetTheme: BottomSheetThemeData(backgroundColor: R.color.transparent),
          ),
          debugShowCheckedModeBanner: false,
          supportedLocales: LanguageController.supportedLocales,
          builder: (_, router) => router!,
        );
      }),
    );
  }
}
