import 'package:lovecity_app/infrastructure/core/http_result.dart';

abstract class IHttpClient {
  Future<HttpResult> get(String url, {Map<String, String> headers});
  Future<HttpResult> post(String url, String body,
      {Map<String, String> headers});
  Future<HttpResult> put();
  Future<HttpResult> delete();
}
