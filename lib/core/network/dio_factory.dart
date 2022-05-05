import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../utils/constants.dart';
import '../utils/storage_keys.dart';
import 'cache_factory.dart';

const String _baseURL = "https://foodsupply.azurewebsites.net/v1/";
const String _applicationJson = "application/json";
const String _contentType = "Content-Type";
const String _authorization = "Authorization";
const String _uid = "uid";
const String _accept = "accept";
const String _lang = "lang";

class DioFactory {
  static late final Dio _dio;

  static Future<void> init() async {
    final BaseOptions _options = BaseOptions(
      baseUrl: _baseURL,
      receiveDataWhenStatusError: true,
      connectTimeout: Constants.connectTimeout,
      receiveTimeout: Constants.connectTimeout,
      sendTimeout: Constants.connectTimeout,
      headers: {
        _contentType: _applicationJson,
        _accept: _applicationJson,
        _lang: "en",
      },
    );

    _dio = Dio(_options);

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }
  }

  static Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    final String? _token = await CacheFactory.getSecuredData(StorageKeys.token);
    final String? _userId = await CacheFactory.getSecuredData(StorageKeys.uid);
    return await _dio.get(
      url,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          _authorization: _token != null ? "Bear $_token" : Constants.empty,
          _uid: _userId ?? Constants.empty,
        },
      ),
    );
  }

  static Future<Response> post({
    required String url,
    required var requestBody,
    Map<String, dynamic>? queryParameters,
  }) async {
    final String? _token = await CacheFactory.getSecuredData(StorageKeys.token);
    final String? _userId = await CacheFactory.getSecuredData(StorageKeys.uid);
    return await _dio.post(
      url,
      queryParameters: queryParameters,
      data: requestBody,
      options: Options(
        headers: {
          _authorization: _token != null ? "Bear $_token" : Constants.empty,
          _uid: _userId ?? Constants.empty,
        },
      ),
    );
  }

  static Future<Response> update({
    required String url,
    required var requestBody,
    Map<String, dynamic>? queryParameters,
  }) async {
    final String? _token = await CacheFactory.getSecuredData(StorageKeys.token);
    final String? _userId = await CacheFactory.getSecuredData(StorageKeys.uid);
    return await _dio.put(
      url,
      queryParameters: queryParameters,
      data: requestBody,
      options: Options(
        headers: {
          _authorization: _token != null ? "Bear $_token" : Constants.empty,
          _uid: _userId ?? Constants.empty,
        },
      ),
    );
  }

  static Future<Response> delete({
    required String url,
    var requestBody,
    Map<String, dynamic>? queryParameters,
  }) async {
    final String? _token = await CacheFactory.getSecuredData(StorageKeys.token);
    final String? _userId = await CacheFactory.getSecuredData(StorageKeys.uid);
    return await _dio.delete(
      url,
      queryParameters: queryParameters,
      data: requestBody,
      options: Options(
        headers: {
          _authorization: _token != null ? "Bear $_token" : Constants.empty,
          _uid: _userId ?? Constants.empty,
        },
      ),
    );
  }
}
