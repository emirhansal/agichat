import 'package:agichat/resources/_r.dart';
import 'package:agichat/service/service_firebase.dart';
import 'package:agichat/service/ui_brightness_style.dart';
import 'package:agichat/widgets/base_bottom_sheet.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'router.dart';

class ServiceRoute extends ChangeNotifier {
  final ServiceFirebase serviceFirebase;
  final UIBrightnessStyle uiBrightnessStyle = UIBrightnessStyle();

  late GlobalKey<NavigatorState> navigatorKey;
  static late RootRouter rootRouter;

  ServiceRoute(this.serviceFirebase) {
    navigatorKey = GlobalKey<NavigatorState>();
    rootRouter = RootRouter();
  }

  void onBackPressed<T extends Object?>([T? result, ChangeNotifier? viewModel]) {
    rootRouter.pop(result);
  }

  Future<T?> startNewView<T>({required PageRouteInfo<dynamic> route, bool isReplace = false, bool clearStack = false}) async {
    if (isReplace && clearStack) {
      await rootRouter.replaceAll([route]);
    } else if (isReplace) {
      return await rootRouter.replace<T>(route);
    } else {
      return await rootRouter.push<T>(route);
    }
    return null;
  }

  Future<void> showBaseBottomSheet(BuildContext context, Widget bottomSheet, {bool isDismissible = true}) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: R.color.black.withOpacity(0.8),
      backgroundColor: R.color.transparent,
      isDismissible: isDismissible,
      builder: (context) => BottomSheetBase(child: bottomSheet),
    );
  }

  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
