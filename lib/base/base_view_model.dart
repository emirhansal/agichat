import 'package:agichat/enums/enum_app.dart';
import 'package:agichat/resources/_r.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

abstract class ViewModelBase extends ChangeNotifier {
  ActivityState activityState = ActivityState.isLoaded;
  ErrorProperty errorObserver = ErrorProperty();

  bool isDetectError = false;
  Map<String, dynamic> errorFields = {};

  void init();

  bool checkErrorByField(String fieldName) {
    return errorFields[fieldName] != null;
  }

  String? getErrorMsg(String fieldName) {
    return errorFields[fieldName].toString();
  }

  void setActivityState(ActivityState state, [String errMsg = '']) {
    activityState = state;
    if (state == ActivityState.isLoading || state == ActivityState.isLoaded) {
      errMsg = '';
    } else {
      errorObserver.message = errMsg;
    }
    notifyListeners();
  }

  bool isLoaded() {
    return activityState == ActivityState.isLoaded;
  }

  bool isLoading() {
    return activityState == ActivityState.isLoading;
  }

  bool isError() {
    return activityState == ActivityState.isError;
  }

  Future<void> handleApiError(dynamic error) async {
    activityState = ActivityState.isError;
    if (error is DioException) {
      errorFields = error.response?.data?['error']?['fields'] ?? {};

      errorObserver.message = (error.message ?? '') + errorFields.toString();
      if (error.response != null) {
        switch (error.response!.statusCode) {
          case 401:
            logout();
            break;
          default:
        }
      }
    } else {
      errorObserver.message = R.string.genericError;
    }
    notifyListeners();
  }

  void logout([bool isDirectLogout = false]) {
    errorObserver.activityErrorActionState = isDirectLogout ? ActivityErrorActionState.directLogout : ActivityErrorActionState.logout;
  }
}

class ErrorProperty extends PropertyChangeNotifier<String> {
  String _message = '';
  String get message => _message;

  ActivityErrorActionState _activityErrorActionState = ActivityErrorActionState.none;
  ActivityErrorActionState get activityErrorActionState => _activityErrorActionState;

  set message(String value) {
    _message = value;
    notifyListeners('errorMessage');
  }

  set activityErrorActionState(ActivityErrorActionState value) {
    _activityErrorActionState = value;
    notifyListeners('activityErrorActionState');
  }
}
