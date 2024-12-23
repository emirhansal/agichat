import 'dart:io';

import 'package:agichat/extensions/controller_language.dart';
import 'package:agichat/resources/_r.dart';
import 'package:agichat/service/api/api_client.dart';
import 'package:agichat/service/service_firebase.dart';
import 'package:agichat/utils/utilities.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

class ServiceApi extends ChangeNotifier {
  late Dio dio;

  late ApiClient _client;

  final ServiceFirebase _firebaseService;

  ApiClient get client => _client;

  final String tagAuthorization = 'Authorization';
  String? accessToken;

  ServiceApi(this.accessToken, this._firebaseService) {
    createDio();
  }

  void createDio() {
    dio = Dio(BaseOptions(headers: accessToken == null ? {} : {tagAuthorization: 'Bearer $accessToken'}, connectTimeout: const Duration(seconds: 120)));

    dio.httpClientAdapter = IOHttpClientAdapter()
      ..createHttpClient = () => HttpClient()..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    dio.interceptors.add(InterceptorsWrapper(onRequest: onRequest, onResponse: onResponse, onError: onError));
    dio.options.headers.addAll(getHeaderData);
    dio.options.followRedirects = false;
    dio.options.validateStatus = (status) {
      return status != null && status < 500;
    };

    createClient();
  }

  void createClient() {
    _client = ApiClient(dio, baseUrl: FlavorConfig.instance.variables['baseUrl']);
  }

  Map<String, String> get getHeaderData {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept-Language': LanguageController.currentLocale.languageCode,
    };
    return headers;
  }

  void reCreateHeaders() {
    dio.options.headers = getHeaderData;
  }

  void setAuthToken(String? accessToken) {
    this.accessToken = accessToken;
    if (accessToken != null) {
      if (dio.options.headers[tagAuthorization] != null) {
        dio.options.headers[tagAuthorization] = 'Bearer $accessToken';
      } else {
        dio.options.headers.addEntries([MapEntry(tagAuthorization, 'Bearer $accessToken')]);
      }
    } else {
      dio.options.headers[tagAuthorization] = null;
    }
  }

  void setTaxNumber(String taxNumber) {
    if (dio.options.headers['X-Tenant'] == null) {
      dio.options.headers.addEntries([MapEntry('X-Tenant', taxNumber)]);
    } else {
      dio.options.headers['X-Tenant'] = taxNumber;
    }
  }

  Future<void> onError(DioException e, ErrorInterceptorHandler handler) async {
    String msg = R.string.genericError;
    if (e.response?.data != null) {
      if (e.response?.data is Map) {
        msg = e.response?.data?['error']?['description'] ?? R.string.genericError;
      } else {
        msg = R.string.genericError;
      }
    }
    await _firebaseService.recordError(parameters: {
      'url': e.requestOptions.uri.toString(),
      'responseCode': e.response?.statusCode,
      'responseMessage': e.response?.statusMessage,
      'requestBody': e.requestOptions.data.toString(),
      'responseBody': e.response?.data.toString(),
      'userSendedMessage': msg,
    });
    e = e.copyWith(message: msg);
    return handler.next(e);
  }

  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (await Utilities.isOnline()) {
      return handler.next(options);
    }
    return handler.reject(DioException(requestOptions: options, message: R.string.networkError));
  }

  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    var isSuccess = (response.data?['status']) ?? false;
    if (isSuccess) {
      return handler.next(response);
    } else {
      DioException e = DioException(requestOptions: RequestOptions(path: ''), response: response);
      String errorMessage = (response.data?['error']?['description'] ?? R.string.genericError);
      e = e.copyWith(message: errorMessage);

      await _firebaseService.recordError(parameters: {
        'url': e.requestOptions.uri.toString(),
        'responseCode': e.response?.statusCode,
        'responseMessage': e.response?.statusMessage,
        'requestBody': e.requestOptions.data.toString(),
        'responseBody': e.response?.data.toString(),
        'userSendedMessage': errorMessage,
      });

      return handler.reject(e);
    }
  }
}
