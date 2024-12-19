import 'package:dio/browser.dart';
import 'package:dio/dio.dart';

final class RestClient extends DioForBrowser {
  RestClient(String baseUrl)
      : super(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 60),
          ),
        );
}
