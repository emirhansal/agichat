import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ServiceDeviceInfo extends ChangeNotifier {
  String deviceId = '';

  String ipAddress = '';
  String macAddress = '';

  String playStoreId = ''; //todo add play store id
  String appStoreId = ''; //todo add app store id

  AndroidDeviceInfo? androidInfo;
  IosDeviceInfo? iosInfo;

  String version = '';
  int buildNumber = 0;

  ServiceDeviceInfo() {
    initialize();
  }

  Future<void> initialize() async {
    // deviceId = (await PlatformDeviceId.getDeviceId) ?? '';
    log(deviceId, name: 'Device Id');
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
    } else {
      iosInfo = await deviceInfo.iosInfo;
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    buildNumber = int.parse(packageInfo.buildNumber);
    log(version, name: Platform.isIOS ? 'iOS Version' : 'Android Version');
    log(buildNumber.toString(), name: 'Build Number');
  }
}
