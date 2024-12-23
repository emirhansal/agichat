import 'dart:io';

import 'package:agichat/base/base_view.dart';
import 'package:agichat/models/model_alert_dialog.dart';
import 'package:agichat/resources/_r.dart';
import 'package:agichat/service/router.gr.dart';
import 'package:agichat/service/service_device_info.dart';
import 'package:agichat/service/ui_brightness_style.dart';
import 'package:agichat/utils/alert_utils.dart';
import 'package:agichat/utils/utilities.dart';
import 'package:agichat/views/splash/vm_splash.dart';
import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../animations/splash_transition.dart';

@RoutePage()
class ViewSplash extends WidgetBase<VmSplash> {
  const ViewSplash({
    super.key,
    super.isActiveLoadingIndicator = true,
  });

  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.dark(systemNavigationBarColor: R.color.white);

  @override
  VmSplash createViewModel(BuildContext context) {
    di<ServiceDeviceInfo>(context);
    return VmSplash(apiService(context), firebaseService(context), di<ServiceDeviceInfo>(context));
  }

  @override
  Widget buildWidget(BuildContext context, VmSplash viewModel) {
    return Scaffold(body: _getBody(context, viewModel));
  }

  @override
  Widget buildWidgetForTablet(BuildContext context, VmSplash viewModel) {
    return Scaffold(body: _getBody(context, viewModel));
  }

  Widget _getBody(BuildContext context, VmSplash viewModel) {
    return _getLogo(context, viewModel);
  }

  Widget _getLogo(BuildContext context, VmSplash viewModel) {
    return Container(
      color: R.color.white,
      child: TransitionSplash(
        child: FadeInLeft(
          child: SvgPicture.asset(R.drawable.svg.logo),
        ),
        onFinish: () => finishAnimation(context, viewModel),
      ),
    );
  }

  Future<void> finishAnimation(BuildContext context, VmSplash viewModel) async {
    var serviceFirebase = viewModel.serviceFirebase;
    var serviceDeviceInfo = di<ServiceDeviceInfo>(context);
    var version = await serviceFirebase.getVersionCode();
    var isUpdateRequired = await serviceFirebase.getIsUpdateRequired();
    if (context.mounted) {
      if (serviceDeviceInfo.buildNumber < version) {
        if (isUpdateRequired) {
          AlertUtils.showPlatformAlert(
            context,
            ModelAlertDialog(
              description: R.string.pleaseUpdateApp,
              isDismissible: false,
              onPressedButton: () {
                Utilities.openStore();
                exit(0);
              },
            ),
          );
          return;
        } else {
          AlertUtils.showToast(R.string.versionCheckMessage((version - serviceDeviceInfo.buildNumber).toString()));
        }
      }
      if (context.mounted) {
        router(context).startNewView(route: RouteHome(), isReplace: true, clearStack: true);
      }
    }
  }
}
