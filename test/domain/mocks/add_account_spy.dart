import 'package:fordev/domain/domain.dart';

import 'package:mocktail/mocktail.dart';

class AddAccountSpy extends Mock implements AddAccount {
  When mockAddAccountCall() => when(() => add(any()));
  void mockAddAccount(AccountEntity data) =>
      mockAddAccountCall().thenAnswer((_) async => data);
  void mockAddAccountError(DomainError error) =>
      mockAddAccountCall().thenThrow(error);
}
