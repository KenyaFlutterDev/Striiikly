import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:striiikly/core/common/constants/app_strings.dart';
import 'package:striiikly/core/common/data/datasources/local/storage_utils.dart';
import 'package:striiikly/core/common/di/injection.dart';

import '../error/exceptions.dart';

@lazySingleton
class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json'};
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          responseBody: false,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: false,
        ),
      );
    }
  }

  Future put(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final apptoken = await getIt<StorageUtils>().getDataForSingle(key: token);

      if (kDebugMode) {
        print('Token: $apptoken');
      }

      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            // Add the access token to the request header
            options.headers['api-key'] = dotenv.env['INDEX_APIKEY'];
            options.headers['Authorization'] = 'Token $apptoken';

            return handler.next(options);
          },
          onError: (DioException e, handler) async {
            if (e.response?.statusCode == 401) {
              // If a 401 response is received, refresh the access token
              //String newAccessToken = await refreshToken();

              // Update the request header with the new access token
              //e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

              // Repeat the request with the updated header
              //return handler.resolve(await dio.fetch(e.requestOptions));
            }
            return handler.next(e);
          },
        ),
      );

      var response = await _dio.put(
        uri,
        data: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data.');
    } catch (e) {
      throw ServerException();
    }
  }

  Future post(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final apptoken = await getIt<StorageUtils>().getDataForSingle(key: token);

      if (kDebugMode) {
        print('Token: $apptoken');
      }
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            // Add the access token to the request header
            options.headers['api-key'] = dotenv.env['INDEX_APIKEY'];
            options.headers['Authorization'] = 'Token $apptoken';

            return handler.next(options);
          },
          onError: (DioException e, handler) async {
            if (e.response?.statusCode == 401) {
              // If a 401 response is received, refresh the access token
              //String newAccessToken = await refreshToken();

              // Update the request header with the new access token
              //e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

              // Repeat the request with the updated header
              //return handler.resolve(await dio.fetch(e.requestOptions));
            }
            if (e.response?.statusCode == 409) {
              // Handle 409 Conflict error
              final errorData = e.response?.data;

              if (kDebugMode) {
                print('Place holder ==> $errorData');
              }

              // return handler.next(errorData);
            }
            return handler.next(e);
          },
        ),
      );

      var response = await _dio.post(
        uri,
        data: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data.');
    } catch (e) {
      throw ServerException();
    }
  }

  Future get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final apptoken = await getIt<StorageUtils>().getDataForSingle(key: token);
      if (kDebugMode) {
        print('Token: $apptoken');
      }
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            // Add the access token to the request header
            if (apptoken.isNotEmpty) {
              options.headers['Authorization'] = 'Token $apptoken';
            }

            return handler.next(options);
          },
          onError: (DioException e, handler) async {
            if (e.response?.statusCode == 401) {
              // If a 401 response is received, refresh the access token
              //String newAccessToken = await refreshToken();

              // Update the request header with the new access token
              //e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

              // Repeat the request with the updated header
              //return handler.resolve(await dio.fetch(e.requestOptions));
            }
            return handler.next(e);
          },
        ),
      );

      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        data: queryParameters,
        // options: Options(headers: {'Authorization': appToken}),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data.');
    } catch (e) {
      throw ServerException();
    }
  }

  Future<int?> checkInternetConenctivity(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final apptoken = await getIt<StorageUtils>().getDataForSingle(key: token);
      if (kDebugMode) {
        print('Token: $apptoken');
      }
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.next(options);
          },
          onError: (DioException e, handler) async {
            if (e.response?.statusCode == 401) {
              // If a 401 response is received, refresh the access token
              //String newAccessToken = await refreshToken();

              // Update the request header with the new access token
              //e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

              // Repeat the request with the updated header
              //return handler.resolve(await dio.fetch(e.requestOptions));
            }
            return handler.next(e);
          },
        ),
      );

      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        data: queryParameters,
        // options: Options(headers: {'Authorization': appToken}),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response.statusCode;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data.');
    } catch (e) {
      throw ServerException();
    }
  }

  Future download({
    required String? filePath,
    required String savePath,
    Options? options,
    CancelToken? cancelToken,
    required ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final apptoken = await getIt<StorageUtils>().getDataForSingle(key: token);
      if (kDebugMode) {
        print('Token: $apptoken');
      }
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            // Add the access token to the request header
            if (apptoken.isNotEmpty) {
              options.headers['Authorization'] = 'Token $apptoken';
            }

            return handler.next(options);
          },
          onError: (DioException e, handler) async {
            if (e.response?.statusCode == 401) {
              // If a 401 response is received, refresh the access token
              //String newAccessToken = await refreshToken();

              // Update the request header with the new access token
              //e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

              // Repeat the request with the updated header
              //return handler.resolve(await dio.fetch(e.requestOptions));
            }
            return handler.next(e);
          },
        ),
      );

      var response = await _dio.download(
        filePath!,
        savePath,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data.');
    } catch (e) {
      throw ServerException();
    }
  }
}
