class HttpResult {
  final String data;
  final Status status;

  HttpResult(this.data, this.status);
}

enum Status { success, failure }
