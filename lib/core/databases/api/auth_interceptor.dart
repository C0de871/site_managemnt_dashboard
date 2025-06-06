import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../features/auth/domain/usecases/retreive_access_token_use_case.dart';

class AuthInterceptor extends Interceptor {
  final RetreiveAccessTokenUseCase retrieveAccessTokenUseCase;

  AuthInterceptor({required this.retrieveAccessTokenUseCase});

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Check if request should be excluded from authentication
    if (options.extra.containsKey('no_auth') && options.extra['no_auth'] == true) {
      // Skip authentication for this request
      return handler.next(options);
    }

    // Get access token from repository
    final tokenResult = await retrieveAccessTokenUseCase.call();

    tokenResult.fold(
      (failure) {
        // If there's a failure, proceed without token
        if (kDebugMode) {
          print('AuthInterceptor: Failed to retrieve token - ${failure.errMessage.toString()}');
        }
        handler.next(options);
      },
      (accessToken) {
        // Add token to headers if available
        if (accessToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        handler.next(options);
      },
    );
  }
}
