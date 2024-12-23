import 'package:agichat/extensions/controller_language.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ExtensionDateTime on DateTime? {
  String montNameAndDay(BuildContext context) {
    if (this == null) {
      return '-';
    }
    return DateFormat('MMMM dd', LanguageController.currentLocale.toLanguageTag()).format(this!.toLocal());
  }

  String dayMonthNameAndYear() {
    if (this == null) {
      return '-';
    }
    return DateFormat('dd MMMM yyyy', LanguageController.currentLocale.toLanguageTag()).format(this!.toLocal());
  }

  String dayMonthNameYearAndMonth() {
    if (this == null) {
      return '-';
    }
    return DateFormat('dd MMMM yyyy HH:ss', LanguageController.currentLocale.toLanguageTag()).format(this!.toLocal());
  }

  String hourAndMinute() {
    if (this == null) {
      return '-';
    }
    return DateFormat('hh:mm', LanguageController.currentLocale.toLanguageTag()).format(this!.toLocal());
  }


  String daydMonth() {
    if (this == null) {
      return '-';
    }
    return DateFormat('dd EEE', LanguageController.currentLocale.toLanguageTag()).format(this!.toLocal());
  }

  String dayNameMonthNameAndHour() {
    if (this == null) {
      return '-';
    }
    return DateFormat('dd MMMM EEEE HH:mm', LanguageController.currentLocale.toLanguageTag()).format(this!.toLocal());
  }

  String dayMonthNameAndDayName() {
    if (this == null) {
      return '-';
    }
    return DateFormat('dd MMMM EEEE', LanguageController.currentLocale.toLanguageTag()).format(this!.toLocal());
  }
  String yearMonthDay() {
    if (this == null) {
      return '-';
    }
    return DateFormat('yyyy-MM-dd', LanguageController.currentLocale.toLanguageTag()).format(this!.toLocal());
  }

  String shortDayName() {
    if (this == null) {
      return '-';
    }
    return DateFormat('EEE', LanguageController.currentLocale.toLanguageTag()).format(this!.toLocal());
  }

  bool isWeekend() {
    if (this == null) {
      return false;
    }
    return this!.weekday == DateTime.saturday || this!.weekday == DateTime.sunday;
  }

  int get weekOfMonth {
    if (this == null) {
      return 0;
    }
    var date = this;
    final firstDayOfTheMonth = DateTime(date!.year, date.month, 1);
    int sum = firstDayOfTheMonth.weekday - 1 + date.day;
    if (sum % 7 == 0) {
      return sum ~/ 7;
    } else {
      return sum ~/ 7 + 1;
    }
  }
}
