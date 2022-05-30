import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class ClientSpy extends Mock implements Client {
  ClientSpy() {
    mockPost(200);
    mockPut(200);
    mockGet(200);
  }

  When mockPostCall() => when(
        () => this.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      );
  void mockPost(int statusCode, {String body = '{"any_key":"any_value"}'}) =>
      mockPostCall().thenAnswer((_) async => Response(body, statusCode));
  void mockPostError() => when(() => mockPostCall().thenThrow(Exception()));

  When mockPutCall() => when(
        () => this.put(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      );
  void mockPut(int statusCode, {String body = '{"any_key":"any_value"}'}) =>
      mockPutCall().thenAnswer((_) async => Response(body, statusCode));
  void mockPutError() => when(() => mockPutCall().thenThrow(Exception()));

  When mockGetCall() =>
      when(() => this.get(any(), headers: any(named: 'headers')));
  void mockGet(int statusCode, {String body = '{"any_key":"any_value"}'}) =>
      mockGetCall().thenAnswer((_) async => Response(body, statusCode));
  void mockGetError() => when(() => mockGetCall().thenThrow(Exception()));
}
