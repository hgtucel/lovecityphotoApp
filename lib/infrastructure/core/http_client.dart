import 'package:lovecity_app/infrastructure/core/http_result.dart';
import 'package:lovecity_app/infrastructure/core/i_http_client.dart';
import 'package:http/http.dart';

class HttpClient implements IHttpClient {
  final Client _client;

  HttpClient(this._client);
  @override
  Future<HttpResult> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<HttpResult> get(String url, {Map<String, String> headers}) async {
    final response = await _client.get(url, headers: headers);
    return HttpResult(response.body, _setStatus(response));
  }

  @override
  Future<HttpResult> post(String url, String body,
      {Map<String, String> headers}) async {
    final response = await _client.post(url, body: body, headers: headers);
    return HttpResult(response.body, _setStatus(response));
  }

  @override
  Future<HttpResult> put() {
    // TODO: implement put
    throw UnimplementedError();
  }

  Status _setStatus(Response response) {
    if (response.statusCode != 200) return Status.failure;
    return Status.success;
  }
}
