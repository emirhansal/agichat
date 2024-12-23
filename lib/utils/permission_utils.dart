import 'dart:async';
import 'dart:io';

import 'package:agichat/models/model_alert_dialog.dart';
import 'package:agichat/resources/_r.dart';
import 'package:agichat/service/service_device_info.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'alert_utils.dart';

Future<bool> accessStoragePermission(BuildContext context) async {
  if (Platform.isAndroid) {
    const permission = PermissionStatus.granted;
    return !permission.isDenied;
  } else {
    final permission = await Permission.storage.request();
    if (permission.isDenied && context.mounted) {
      unawaited(AlertUtils.showPlatformAlert(context, ModelAlertDialog(description: R.string.accessStoragePermission)));
    }
    return !permission.isDenied;
  }
}

Future<bool> accessCameraPermission(BuildContext context) async {
  final permission = await Permission.camera.request();
  if (permission.isDenied && context.mounted) {
    unawaited(AlertUtils.showPlatformAlert(context, ModelAlertDialog(description: R.string.accessCameraPermission)));
  }
  return !permission.isDenied;
}

Future<bool> accessGalleryPermission(BuildContext context) async {
  if (Platform.isAndroid) {
    final sdkInt = Provider.of<ServiceDeviceInfo>(context, listen: false).androidInfo!.version.sdkInt;
    late PermissionStatus permission;
    if (context.mounted) {
      permission = (Platform.isAndroid && sdkInt >= 33) ? PermissionStatus.granted : await Permission.storage.request();
      if (permission.isDenied && context.mounted) {
        unawaited(AlertUtils.showPlatformAlert(context, ModelAlertDialog(description: R.string.accessGalleryPermission)));
      }
    }
    return !permission.isDenied;
  } else {
    final permission = await Permission.photos.request();
    if (permission.isDenied && context.mounted) {
      unawaited(AlertUtils.showPlatformAlert(context, ModelAlertDialog(description: R.string.accessGalleryPermission)));
    }
    return !permission.isDenied;
  }
}

Future<bool> accessGalleryVideosPermission(BuildContext context) async {
  if (Platform.isAndroid) {
    final sdkInt = Provider.of<ServiceDeviceInfo>(context, listen: false).androidInfo!.version.sdkInt;
    late PermissionStatus permission;
    if (context.mounted) {
      permission = (Platform.isAndroid && sdkInt >= 33) ? PermissionStatus.granted : await Permission.storage.request();
      if (permission.isDenied && context.mounted) {
        unawaited(AlertUtils.showPlatformAlert(context, ModelAlertDialog(description: R.string.accessGalleryPermission)));
      }
    }
    return !permission.isDenied;
  } else {
    final permission = await Permission.videos.request();
    if (permission.isDenied && context.mounted) {
      unawaited(AlertUtils.showPlatformAlert(context, ModelAlertDialog(description: R.string.accessGalleryPermission)));
    }
    return !permission.isDenied;
  }
}

Future<bool> accessLocationPermission(BuildContext context) async {
  final permission = await Permission.location.request();
  if (permission.isDenied && context.mounted) {
    unawaited(AlertUtils.showPlatformAlert(context, ModelAlertDialog(description: R.string.accessLocationPermission)));
  }
  return !permission.isDenied;
}

