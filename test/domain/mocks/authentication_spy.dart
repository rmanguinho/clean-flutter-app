import 'package:fordev/domain/domain.dart';

import 'package:mocktail/mocktail.dart';

class AuthenticationSpy extends Mock implements Authentication {
  When mockAuthenticationCall() => when(() => auth(any()));
  void mockAuthentication(AccountEntity data) =>
      mockAuthenticationCall().thenAnswer((_) async => data);
  void mockAuthenticationError(DomainError error) =>
      mockAuthenticationCall().thenThrow(error);
}
