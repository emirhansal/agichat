import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

import 'general_data.dart';
import 'dart:ui' as ui;

class Utilities {
  static Future<bool> isOnline() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static dynamic getUserSp(String id, {dynamic defaultValue}) {
    return GeneralData.getInstance().hive.get(id, defaultValue: defaultValue);
  }

  static void setUserSp(String id, dynamic value) async {
    return await GeneralData.getInstance().hive.put(id, value);
  }

  static void openStore() async {
    // await LaunchReview.launch(androidAppId: AppConfig.playStoreId, iOSAppId: AppConfig.appStoreId);
  }

  static Future<String> printIps() async {
    String address = '';
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        address = addr.address;
      }
    }
    return address;
  }

  static List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  static String convertToJsonForNotEqualQuotes(String str) {
    str = str.toString().replaceAll('{', '{"');
    str = str.toString().replaceAll(': ', '": "');
    str = str.toString().replaceAll(', ', '", "');
    str = str.toString().replaceAll('}', '"}');
    return str;
  }

  static Future<ui.Image> getImage(String path) async {
    var completer = Completer<ImageInfo>();
    var img = NetworkImage(path);
    img.resolve(const ImageConfiguration()).addListener(ImageStreamListener((info, _) {
      completer.complete(info);
    }));
    ImageInfo imageInfo = await completer.future;
    return imageInfo.image;
  }
}
