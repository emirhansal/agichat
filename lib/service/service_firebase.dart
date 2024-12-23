import 'dart:io';

import 'package:agichat/enums/enum_app.dart';
import 'package:agichat/utils/general_data.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

import 'service_device_info.dart';

class ServiceFirebase extends ChangeNotifier {
  late FirebaseAnalytics analytics;
  late FirebaseCrashlytics crashlytics;
  late FirebaseRemoteConfig remoteConfig;
  final ServiceDeviceInfo serviceDeviceInfo;

  Map<String, dynamic> mParameters = {};

  bool get isProd => FlavorConfig.instance.name == Flavor.prod.value;

  ServiceFirebase(this.serviceDeviceInfo) {
    initialize();

    mParameters.addAll({
      'authToken': GeneralData.getInstance().getAuthToken().toString(),
      'fcmToken': GeneralData.getInstance().getFCMToken().toString(),
      'username': GeneralData.getInstance().getUsername().toString(),
      'platform': Platform.isIOS ? 'iOS' : 'Android',
      'model': Platform.isIOS ? serviceDeviceInfo.iosInfo?.model : '${serviceDeviceInfo.androidInfo?.model} + ${serviceDeviceInfo.androidInfo?.brand}',
      'systemName': Platform.isIOS ? serviceDeviceInfo.iosInfo?.systemName : serviceDeviceInfo.androidInfo?.device,
      'systemVersion': Platform.isIOS ? serviceDeviceInfo.iosInfo?.systemVersion : serviceDeviceInfo.androidInfo?.version,
      'nameOrHardware': Platform.isIOS ? serviceDeviceInfo.iosInfo?.name : serviceDeviceInfo.androidInfo?.hardware,
      'deviceId': Platform.isIOS ? serviceDeviceInfo.iosInfo?.identifierForVendor : serviceDeviceInfo.androidInfo?.id,
    });
  }

  Future<void> initialize() async {
    analytics = FirebaseAnalytics.instance;
    crashlytics = FirebaseCrashlytics.instance;
    remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 1),
        minimumFetchInterval: const Duration(seconds: 1),
      ),
    );

    await remoteConfig.ensureInitialized();
    await remoteConfig.fetchAndActivate();
  }

  Future<void> setUserId(String userId) async {
    await analytics.setUserId(id: userId);
    await crashlytics.setUserIdentifier(userId);

    if (isProd) {
      analytics.setAnalyticsCollectionEnabled(true);
      crashlytics.setCrashlyticsCollectionEnabled(true);
    } else {
      analytics.setAnalyticsCollectionEnabled(false);
      crashlytics.setCrashlyticsCollectionEnabled(false);
    }
  }

  Future<void> recordError({Map<String, dynamic>? parameters, StackTrace? stackTrace, String? reason, bool fatal = true}) async {
    if (isProd) {
      parameters?.addAll(mParameters);
      await crashlytics.recordError(
        parameters,
        stackTrace,
        reason: reason,
        fatal: fatal,
      );
    }
  }

  Future<int> getVersionCode() async {
    return remoteConfig.getInt(Platform.isAndroid ? 'androidVersionCode' : 'iosVersionCode');
  }

  Future<bool> getIsUpdateRequired() async {
    return remoteConfig.getBool(Platform.isAndroid ? 'androidIsUpdateRequired' : 'iosIsUpdateRequired');
  }
}
