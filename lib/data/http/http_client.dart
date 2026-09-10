abstract class HttpClient {
  Future<dynamic> request({
    required String url,
    required String method,
    Map? body,
    Map? headers,
  });
}
