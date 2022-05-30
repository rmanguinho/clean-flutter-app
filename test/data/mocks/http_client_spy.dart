import 'package:fordev/data/data.dart';

import 'package:mocktail/mocktail.dart';

class HttpClientSpy extends Mock implements HttpClient {
  When mockRequestCall() => when(
        () => request(
          url: any(named: 'url'),
          method: any(named: 'method'),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      );
  void mockRequest(dynamic data) =>
      mockRequestCall().thenAnswer((_) async => data);
  void mockRequestError(HttpError error) => mockRequestCall().thenThrow(error);
}
